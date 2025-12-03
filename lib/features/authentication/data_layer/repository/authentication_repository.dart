import 'package:final_project/features/authentication/data_layer/datasource/authentication_datasource.dart';
import 'package:final_project/features/authentication/domain_layer/entity/authentication_entity.dart';
import 'package:final_project/features/authentication/domain_layer/repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthenticationRepositoryDomain)
class DataRepository implements AuthenticationRepositoryDomain {
  final AuthenticationDatasource datasource;

  DataRepository(this.datasource);

  @override
  Future<AuthenticationEntity> signIn({
    required String email,
    required String password,
  }) async {
    final model = await datasource.signIn(email: email, password: password);
    return model;
  }

  @override
  Future<AuthenticationEntity> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final model = await datasource.signUp(
      username: username,
      email: email,
      password: password,
    );
    return model;
  }

  @override
  Future<void> signOut() async {
    await datasource.signOut();
  }

  @override
  Future<void> sendResetPasswordEmail({required String email}) {
    return datasource.sendResetPasswordEmail(email: email);
  }

  @override
  Future<void> verifyResetCode({
    required String email,
    required String code,
  }) async {
    await datasource.verifyResetCode(email: email, code: code);
  }

  @override
  Future<void> updatePassword({
    required String email,
    required String newPassword,
  }) async {
    await datasource.updatePassword(newPassword: newPassword);
  }

  @override
  Future<void> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    await datasource.verifyEmailOtp(email: email, otp: otp);
  }
}
