import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:final_project/features/profile/data_layer/datasource/profile_datasource.dart';
import 'package:final_project/features/profile/domain_layer/entity/profile_entity.dart';
import 'package:final_project/features/profile/domain_layer/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource datasource;

  ProfileRepositoryImpl(this.datasource);

  @override
  Future<Either<String, ProfileEntity>> getProfile() async {
    try {
      final profile = await datasource.getProfile();
      return Right(profile);
    } catch (e) {
      return Left('Failed to get profile: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, ProfileEntity>> updateProfile({
    String? username,
    String? fullName,
    String? phoneNumber,
  }) async {
    try {
      final profile = await datasource.updateProfile(
        username: username,
        fullName: fullName,
        phoneNumber: phoneNumber,
      );
      return Right(profile);
    } catch (e) {
      return Left('Failed to update profile: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, String>> uploadAvatar(
    Uint8List imageBytes,
    String fileName,
  ) async {
    try {
      final avatarUrl = await datasource.uploadAvatar(imageBytes, fileName);
      return Right(avatarUrl);
    } catch (e) {
      return Left('Failed to upload avatar: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, ProfileEntity>> updateAvatarUrl(String avatarUrl) async {
    try {
      final profile = await datasource.updateAvatarUrl(avatarUrl);
      return Right(profile);
    } catch (e) {
      return Left('Failed to update avatar URL: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, String>> softDeleteAccount(String reason) async {
    try {
      final message = await datasource.softDeleteAccount(reason);
      return Right(message);
    } catch (e) {
      return Left('Failed to delete account: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, String>> restoreAccount() async {
    try {
      final message = await datasource.restoreAccount();
      return Right(message);
    } catch (e) {
      return Left('Failed to restore account: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> signOut() async {
    try {
      await datasource.signOut();
      return const Right(null);
    } catch (e) {
      return Left('Failed to sign out: ${e.toString()}');
    }
  }
}
