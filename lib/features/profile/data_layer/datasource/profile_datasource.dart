import 'dart:typed_data';
import 'package:final_project/features/profile/data_layer/model/profile_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileDatasource {
  Future<ProfileModel> getProfile();

  Future<ProfileModel> updateProfile({
    String? username,
    String? fullName,
    String? phoneNumber,
  });

  Future<String> uploadAvatar(Uint8List imageBytes, String fileName);

  Future<ProfileModel> updateAvatarUrl(String avatarUrl);

  Future<String> softDeleteAccount(String reason);

  Future<String> restoreAccount();

  Future<void> signOut();
}

@LazySingleton(as: ProfileDatasource)
class SupabaseProfileDatasource implements ProfileDatasource {
  final SupabaseClient supabase;

  SupabaseProfileDatasource(this.supabase);

  @override
  Future<ProfileModel> getProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    // Fetch profile from Supabase
    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    // Update last_login_at
    await supabase.from('profiles').update({
      'last_login_at': DateTime.now().toIso8601String(),
    }).eq('id', user.id);

    return ProfileModelMapper.fromMap(response);
  }

  @override
  Future<ProfileModel> updateProfile({
    String? username,
    String? fullName,
    String? phoneNumber,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    final updates = <String, dynamic>{};
    if (username != null) updates['username'] = username;
    if (fullName != null) updates['full_name'] = fullName;
    if (phoneNumber != null) updates['phone_number'] = phoneNumber;

    if (updates.isEmpty) {
      throw Exception('No fields to update');
    }

    final response = await supabase
        .from('profiles')
        .update(updates)
        .eq('id', user.id)
        .select()
        .single();

    return ProfileModelMapper.fromMap(response);
  }

  @override
  Future<String> uploadAvatar(Uint8List imageBytes, String fileName) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    // Upload to Supabase Storage
    final path = 'avatars/${user.id}/$fileName';

    await supabase.storage.from('profiles').uploadBinary(
          path,
          imageBytes,
          fileOptions: const FileOptions(
            upsert: true,
            contentType: 'image/jpeg',
          ),
        );

    // Get public URL
    final publicUrl = supabase.storage.from('profiles').getPublicUrl(path);

    return publicUrl;
  }

  @override
  Future<ProfileModel> updateAvatarUrl(String avatarUrl) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    final response = await supabase
        .from('profiles')
        .update({'avatar_url': avatarUrl})
        .eq('id', user.id)
        .select()
        .single();

    return ProfileModelMapper.fromMap(response);
  }

  @override
  Future<String> softDeleteAccount(String reason) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    await supabase.from('profiles').update({
      'status': 'deleted',
      'is_active': false,
    }).eq('id', user.id);

    // Sign out after soft delete
    await supabase.auth.signOut();

    return 'Account deleted successfully';
  }

  @override
  Future<String> restoreAccount() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    await supabase.from('profiles').update({
      'status': 'active',
      'is_active': true,
    }).eq('id', user.id);

    return 'Account restored successfully';
  }

  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
