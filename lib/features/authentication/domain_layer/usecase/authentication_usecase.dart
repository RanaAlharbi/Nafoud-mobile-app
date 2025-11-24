import 'package:final_project/features/authentication/domain_layer/entity/authentication_entity.dart';
import 'package:final_project/features/authentication/domain_layer/repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthenticationUsecases {
  final AuthenticationRepositoryDomain authRepo;

  AuthenticationUsecases({required this.authRepo});

  Future<AuthenticationEntity> signIn({
    required String email,
    required String password,
  }) {
    return authRepo.signIn(email: email, password: password);
  }

  Future<AuthenticationEntity> signUp({
    required String username,
    required String email,
    required String password,
  }) {
    return authRepo.signUp(
      username: username,
      email: email,
      password: password,
    );
  }

  Future<void> signOut() {
    return authRepo.signOut();
  }

  Future<void> sendResetPasswordEmail({required String email}) {
    return authRepo.sendResetPasswordEmail(email: email);
  }

  Future<void> verifyResetCode({required String email, required String code}) {
    return authRepo.verifyResetCode(email: email, code: code);
  }

  Future<void> updatePassword({
    required String email,
    required String newPassword,
  }) {
    return authRepo.updatePassword(email: email, newPassword: newPassword);
  }
}
