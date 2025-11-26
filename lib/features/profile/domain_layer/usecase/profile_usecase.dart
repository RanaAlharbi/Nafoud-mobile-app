import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entity/profile_entity.dart';
import '../repository/profile_repository.dart';

@injectable
class ProfileUsecase {
  final ProfileRepository _repository;

  ProfileUsecase(this._repository);

  // Get current user's profile
  Future<Either<String, ProfileEntity>> getProfile() async {
    return await _repository.getProfile();
  }

  // Update user's profile information
  Future<Either<String, ProfileEntity>> updateProfile({
    String? username,
    String? phoneNumber,
  }) async {
    return await _repository.updateProfile(
      username: username,
      phoneNumber: phoneNumber,
    );
  }

  // Upload and update user's avatar
  Future<Either<String, String>> uploadAvatar(
    Uint8List imageBytes,
    String fileName,
  ) async {
    return await _repository.uploadAvatar(imageBytes, fileName);
  }

  // Update user's avatar URL
  Future<Either<String, ProfileEntity>> updateAvatarUrl(String avatarUrl) async {
    return await _repository.updateAvatarUrl(avatarUrl);
  }

  // Soft delete user's account (there'll be no hard delete as Fahad requested)
  Future<Either<String, String>> softDeleteAccount(String reason) async {
    return await _repository.softDeleteAccount(reason);
  }

  // Restore deleted account (idk if we will implement this function, so I'll leave it here)
  Future<Either<String, String>> restoreAccount() async {
    return await _repository.restoreAccount();
  }

  // Sign out user
  Future<Either<String, void>> signOut() async {
    return await _repository.signOut();
  }
}
