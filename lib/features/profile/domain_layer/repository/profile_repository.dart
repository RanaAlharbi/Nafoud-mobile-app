import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<String, ProfileEntity>> getProfile();

  // Update user's profile info
  Future<Either<String, ProfileEntity>> updateProfile({
    String? username, // Unique username/nickname
    String? fullName, // User's actual full name
    String? phoneNumber,
  });

  // Upload and update user's avatar | fileName incase if the image didn't load then we know the file path/name
  Future<Either<String, String>> uploadAvatar(Uint8List imageBytes, String fileName);

  // Update user's avatar URL
  Future<Either<String, ProfileEntity>> updateAvatarUrl(String avatarUrl);

  // Soft delete user's account
  Future<Either<String, String>> softDeleteAccount(String reason);

  // Restore deleted account, idk if we will implement it or not but it would be here for now
  Future<Either<String, String>> restoreAccount();

  // Sign out user
  Future<Either<String, void>> signOut();
}
