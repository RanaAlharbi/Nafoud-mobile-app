import 'package:final_project/features/authentication/data_layer/model/authentication_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthenticationDatasource {
  Future<AuthenticationModel> signIn({
    required String email,
    required String password,
  });

  Future<AuthenticationModel> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> sendResetPasswordEmail({required String email});

  Future<void> verifyResetCode({required String email, required String code});

  Future<void> updatePassword({required String newPassword});

  Future<void> verifyEmailOtp({required String email, required String otp});
}

@LazySingleton(as: AuthenticationDatasource)
class SupabaseDatasource implements AuthenticationDatasource {
  final SupabaseClient supabase;
  final GetStorage _storage;

  SupabaseDatasource(this.supabase, this._storage);

  @override
  Future<AuthenticationModel> signIn({
    required String email,
    required String password,
  }) async {
    // Clear any cached profile data from previous user before signing in (made by Mohammed)
    await _storage.remove('cached_profile');

    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final session = response.session;
    if (session == null) {
      throw Exception('Sign in failed: no session returned');
    }

    // Check if profile exists, if not create one
    final userId = response.user?.id;
    if (userId != null) {
      final existingProfile = await supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (existingProfile == null) {
        // Create profile if it doesn't exist with all required fields
        final defaultUsername = email.split('@')[0];
        await supabase.from('profiles').upsert({
          'id': userId,
          'email': email,
          'username': defaultUsername,
          'full_name': defaultUsername,
        });
      }
    }

    return AuthenticationModel.fromSession(session);
  }

  @override
  Future<AuthenticationModel> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );
    final session = response.session;
    if (session == null) {
      return AuthenticationModel(accessToken: '', refreshToken: '');
    }

    final userId = response.user?.id;
    if (userId != null) {
      await supabase.from('profiles').upsert({
        'id': userId,
        'username': username,
        'email': email,
        'full_name': username,
        'is_active': true,
      });
    }
    return AuthenticationModel.fromSession(session);
  }

  @override
  Future<void> signOut() async {
    // Clear profile cache before signing out (made by Mohammed)
    await _storage.remove('cached_profile');
    await supabase.auth.signOut();
  }

  @override
  Future<void> sendResetPasswordEmail({required String email}) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> verifyResetCode({
    required String email,
    required String code,
  }) async {
    await supabase.auth.verifyOTP(
      email: email,
      token: code,
      type: OtpType.recovery,
    );
  }

  @override
  Future<void> updatePassword({required String newPassword}) async {
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  @override
  Future<void> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    await supabase.auth.verifyOTP(
      email: email,
      token: otp,
      type: OtpType.signup,
    );
  }
}
