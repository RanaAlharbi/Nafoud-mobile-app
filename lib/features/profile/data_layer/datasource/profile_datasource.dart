import 'dart:typed_data';
import 'package:final_project/features/profile/data_layer/model/profile_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_cache_service.dart';

abstract class ProfileDatasource {
  Future<ProfileModel> getProfile();

  Future<ProfileModel> updateProfile({
    String? username,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? address,
    String? gender,
    String? nationality,
  });

  Future<String> uploadAvatar(Uint8List imageBytes, String fileName);

  Future<ProfileModel> updateAvatarUrl(String avatarUrl);

  Future<String> softDeleteAccount();

  Future<String> restoreAccount();

  Future<void> signOut();
}

@LazySingleton(as: ProfileDatasource)
class SupabaseProfileDatasource implements ProfileDatasource {
  final SupabaseClient supabase;
  final ProfileCacheService _cacheService;

  SupabaseProfileDatasource(this.supabase, this._cacheService);

  @override
  Future<ProfileModel> getProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    // Return cached profile first so it will be there 0 loading
    final cachedData = _cacheService.getCachedProfile();
    if (cachedData != null) {
      try {
        // IMPORTANT: Validate that cached profile belongs to current user
        if (cachedData['id'] == user.id) {
          // Return cached data fast (no loading)
          return ProfileModelMapper.fromMap(cachedData);
        } else {
          // Cache is for a different user, clear it
          await _cacheService.clearProfile();
        }
      } catch (e) {
        // If cache have some issues, clear it and fetch new data
        await _cacheService.clearProfile();
      }
    }

    // Only fetch from Supabase if no cache exists
    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    // Update last_login_at
    await supabase
        .from('profiles')
        .update({'last_login_at': DateTime.now().toIso8601String()})
        .eq('id', user.id);

    // Save new data to cache for next time
    await _cacheService.saveProfile(response);

    return ProfileModelMapper.fromMap(response);
  }

  @override
  Future<ProfileModel> updateProfile({
    String? username,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? address,
    String? gender,
    String? nationality,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    final updates = <String, dynamic>{};
    if (username != null) updates['username'] = username;
    if (fullName != null) updates['full_name'] = fullName;
    if (email != null) updates['email'] = email;
    if (phoneNumber != null) updates['phone_number'] = phoneNumber;
    if (address != null) updates['address'] = address;
    if (gender != null) updates['gender'] = gender;
    if (nationality != null) updates['nationality'] = nationality;

    if (updates.isEmpty) {
      throw Exception('No fields to update');
    }

    final response = await supabase
        .from('profiles')
        .update(updates)
        .eq('id', user.id)
        .select()
        .single();

    // Update cache with new profile data
    await _cacheService.saveProfile(response);

    return ProfileModelMapper.fromMap(response);
  }

  @override
  Future<String> uploadAvatar(Uint8List imageBytes, String fileName) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    // Create unique filename with timestamp to prevent problems
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = fileName.split('.').last.toLowerCase();
    final uniqueFileName = 'avatar_$timestamp.$extension';

    String contentType = 'image/jpeg';
    if (extension == 'png') {
      contentType = 'image/png';
    } else if (extension == 'gif') {
      contentType = 'image/gif';
    } else if (extension == 'webp') {
      contentType = 'image/webp';
    } else if (extension == 'jpg' || extension == 'jpeg') {
      contentType = 'image/jpeg';
    }

    // Upload to Supabase Storage
    final path = 'avatars/${user.id}/$uniqueFileName';

    try {
      await supabase.storage
          .from('profiles')
          .uploadBinary(
            path,
            imageBytes,
            fileOptions: FileOptions(upsert: true, contentType: contentType),
          );
    } catch (e) {
      throw Exception('Failed to upload image to storage: $e');
    }

    // Get Photo URL
    final publicUrl = supabase.storage.from('profiles').getPublicUrl(path);
    final urlWithCacheBust = '$publicUrl?t=$timestamp';

    return urlWithCacheBust;
  }

  @override
  Future<ProfileModel> updateAvatarUrl(String avatarUrl) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    try {
      final response = await supabase
          .from('profiles')
          .update({'avatar_url': avatarUrl})
          .eq('id', user.id)
          .select()
          .single();

      // Update cache with new avatar URL
      await _cacheService.saveProfile(response);

      return ProfileModelMapper.fromMap(response);
    } catch (e) {
      throw Exception('Failed to update avatar URL in database: $e');
    }
  }

  @override
  Future<String> softDeleteAccount() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    try {
      // Updates auth.users.deleted_at, which will sync profiles table
      final response = await supabase.rpc('soft_delete_account');

      if (response['success'] != true) {
        final error = response['message'] ?? 'Failed to delete account';
        throw Exception(error);
      }

      // Clear cache before sign out
      await _cacheService.clearAll();

      // Sign out after soft delete
      await supabase.auth.signOut();

      return response['message'] ?? 'Account deleted successfully';
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  @override
  Future<String> restoreAccount() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    try {
      // Clears auth.users.deleted_at, which will sync profiles table
      final response = await supabase.rpc('restore_account');

      if (response['success'] != true) {
        final error = response['message'] ?? 'Failed to restore account';
        throw Exception(error);
      }

      // Clear cache to force fresh data on next load
      await _cacheService.clearProfile();

      return response['message'] ?? 'Account restored successfully';
    } catch (e) {
      throw Exception('Failed to restore account: $e');
    }
  }

  @override
  Future<void> signOut() async {
    // Clear cache before signing out
    await _cacheService.clearAll();

    await supabase.auth.signOut();
  }
}
