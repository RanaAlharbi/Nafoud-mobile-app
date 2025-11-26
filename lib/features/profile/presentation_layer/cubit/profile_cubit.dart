import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain_layer/usecase/profile_usecase.dart';
import '../../domain_layer/entity/profile_entity.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUsecase _usecase;

  ProfileCubit(this._usecase) : super(ProfileInitial());

  // Load user profile
  Future<void> loadProfile() async {
    emit(ProfileLoading());

    final result = await _usecase.getProfile();

    result.fold(
      (error) => emit(ProfileError(error)),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }

  // Update user profile
  Future<void> updateProfile({
    String? username,
    String? phoneNumber,
  }) async {
    emit(ProfileUpdating());

    final result = await _usecase.updateProfile(
      username: username,
      phoneNumber: phoneNumber,
    );

    result.fold(
      (error) => emit(ProfileError(error)),
      (profile) => emit(ProfileUpdated(profile, 'Profile updated successfully')),
    );
  }

  // Upload avatar image
  Future<void> uploadAvatar(Uint8List imageBytes, String fileName) async {
    emit(AvatarUploading());

    // First upload the image
    final uploadResult = await _usecase.uploadAvatar(imageBytes, fileName);

    await uploadResult.fold(
      (error) async => emit(ProfileError(error)),
      (avatarUrl) async {
        // Then update the profile with the new avatar URL
        final updateResult = await _usecase.updateAvatarUrl(avatarUrl);

        updateResult.fold(
          (error) => emit(ProfileError(error)),
          (profile) => emit(AvatarUploaded(profile, 'Avatar updated successfully')),
        );
      },
    );
  }

  // Soft delete account
  Future<void> deleteAccount(String reason) async {
    emit(AccountDeleting());

    final result = await _usecase.softDeleteAccount(reason);

    result.fold(
      (error) => emit(ProfileError(error)),
      (message) => emit(AccountDeleted(message)),
    );
  }

  // Restore deleted account
  Future<void> restoreAccount() async {
    emit(ProfileLoading());

    final result = await _usecase.restoreAccount();

    result.fold(
      (error) => emit(ProfileError(error)),
      (message) => emit(AccountRestored(message)),
    );
  }

  // Sign out
  Future<void> signOut() async {
    emit(ProfileLoading());

    final result = await _usecase.signOut();

    result.fold(
      (error) => emit(ProfileError(error)),
      (_) => emit(SignedOut()),
    );
  }
}
