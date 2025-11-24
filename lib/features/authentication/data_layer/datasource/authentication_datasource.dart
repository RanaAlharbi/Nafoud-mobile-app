import 'package:final_project/features/authentication/data_layer/model/authentication_model.dart';
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
}

@LazySingleton(as: AuthenticationDatasource)
class SupabaseDatasource implements AuthenticationDatasource {
  final SupabaseClient supabase;

  SupabaseDatasource(this.supabase);

  @override
  Future<AuthenticationModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final session = response.session;
    if (session == null) {
      throw Exception('Sign in failed: no session returned');
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
      });
    }
    return AuthenticationModel.fromSession(session);
  }

  @override
  Future<void> signOut() async {
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
}
