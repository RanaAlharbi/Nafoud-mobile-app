import 'package:final_project/features/authentication/domain_layer/entity/authentication_entity.dart';

abstract class AuthenticationRepositoryDomain {
  Future<AuthenticationEntity> signIn({
    required String email,
    required String password,
  });

  Future<AuthenticationEntity> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> sendResetPasswordEmail({required String email});

  Future<void> verifyResetCode({required String email, required String code});

  Future<void> updatePassword({
    required String email,
    required String newPassword,
  });
}
