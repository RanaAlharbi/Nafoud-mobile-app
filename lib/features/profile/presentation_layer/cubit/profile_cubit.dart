import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // TEMPORARY: For test login
import '../../domain_layer/usecase/profile_usecase.dart';
import '../../domain_layer/entity/profile_entity.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUsecase _usecase;

  ProfileCubit(this._usecase) : super(ProfileInitial());


  // TODO: Remove this when sign-in page is created (from here)
  Future<void> _testAutoLogin() async {
    final supabase = Supabase.instance.client;

    // Check if already logged in
    if (supabase.auth.currentUser != null) {
      print('Already logged in as: ${supabase.auth.currentUser!.email}');
      return;
    }

    try {
      print('Test login...');
      await supabase.auth.signInWithPassword(
        email: 'test@example.com',
        password: 'Test123456!',
      );
      print('Test login success');
    } catch (e) {
      print('Test login failed: $e');
    }
  }

  // TODO: ============================ (TO HERE) ============================ 

  // Load user profile
  Future<void> loadProfile() async {
    await _testAutoLogin(); // TODO: Remove this when sign-in page is created

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
    String? fullName,
    String? phoneNumber,
  }) async {
    emit(ProfileUpdating());

    final result = await _usecase.updateProfile(
      username: username,
      fullName: fullName,
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

  // Initialize form for editing with current profile data
  void initializeFormForEditing(ProfileEntity profile) {
    emit(ProfileFormState(
      fullName: profile.fullName,
      username: profile.username,
      email: profile.email,
      phoneNumber: profile.phoneNumber ?? '',
      address: '',
      selectedCountry: null,
      selectedGenre: null,
    ));
  }

  // Update a form field
  void updateFormField(String fieldName, String value) {
    if (state is ProfileFormState) {
      final currentState = state as ProfileFormState;
      ProfileFormState newState;

      switch (fieldName) {
        case 'fullName':
          newState = currentState.copyWith(fullName: value);
          break;
        case 'username':
          newState = currentState.copyWith(username: value);
          break;
        case 'phoneNumber':
          newState = currentState.copyWith(phoneNumber: value);
          break;
        case 'address':
          newState = currentState.copyWith(address: value);
          break;
        default:
          return;
      }

      emit(newState);
    }
  }

  // Update country dropdown
  void updateCountry(String? country) {
    if (state is ProfileFormState) {
      final currentState = state as ProfileFormState;
      emit(currentState.copyWith(selectedCountry: country));
    }
  }

  // Update genre dropdown
  void updateGenre(String? genre) {
    if (state is ProfileFormState) {
      final currentState = state as ProfileFormState;
      emit(currentState.copyWith(selectedGenre: genre));
    }
  }

  // Validate and submit the form
  Future<void> validateAndSubmitForm() async {
    if (state is! ProfileFormState) return;

    final formState = state as ProfileFormState;
    final errors = <String, String>{};

    // Validation
    if (formState.fullName.trim().isEmpty) {
      errors['fullName'] = 'Full name is required';
    }

    if (formState.username.trim().isEmpty) {
      errors['username'] = 'Username is required';
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(formState.username)) {
      errors['username'] = 'Username can only contain letters, numbers, and underscores';
    }

    if (errors.isNotEmpty) {
      emit(formState.copyWith(validationErrors: errors));
      return;
    }

    // Clear errors and set submitting state
    emit(formState.copyWith(validationErrors: {}, isSubmitting: true));

    // Submit the update
    final result = await _usecase.updateProfile(
      username: formState.username.trim(),
      fullName: formState.fullName.trim(),
      phoneNumber: formState.phoneNumber.trim().isNotEmpty ? formState.phoneNumber.trim() : null,
    );

    result.fold(
      (error) => emit(ProfileError(error)),
      (profile) => emit(ProfileUpdated(profile, 'Profile updated successfully')),
    );
  }
}
