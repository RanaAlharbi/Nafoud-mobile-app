import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain_layer/usecase/profile_usecase.dart';
import '../../domain_layer/entity/profile_entity.dart';
import '../../domain_layer/entity/country_code_entity.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUsecase _usecase;

  ProfileCubit(this._usecase) : super(ProfileInitial());

  // Load user profile
  Future<void> loadProfile() async {
    if (isClosed) return;
    emit(ProfileLoading());

    final result = await _usecase.getProfile();

    if (isClosed) return;
    result.fold(
      (error) => emit(ProfileError(error)),
      (profile) => emit(ProfileLoaded(profile)), // Error here
    );
  }

  // Update user profile
  Future<void> updateProfile({
    String? username,
    String? fullName,
    String? phoneNumber,
  }) async {
    if (isClosed) return;
    emit(ProfileUpdating());

    final result = await _usecase.updateProfile(
      username: username,
      fullName: fullName,
      phoneNumber: phoneNumber,
    );

    if (isClosed) return;
    result.fold(
      (error) => emit(ProfileError(error)),
      (profile) => emit(ProfileUpdated(profile, 'Profile updated successfully')),
    );
  }

  // Upload avatar image
  Future<void> uploadAvatar(Uint8List imageBytes, String fileName) async {
    if (isClosed) return;
    // So it can update
    emit(AvatarUploading());

    // First upload the image
    final uploadResult = await _usecase.uploadAvatar(imageBytes, fileName);

    if (isClosed) return;
    await uploadResult.fold(
      (error) async {
        if (!isClosed) emit(ProfileError(error));
      },
      (avatarUrl) async {

        // Then update the profile with the new avatar URL
        final updateResult = await _usecase.updateAvatarUrl(avatarUrl);

        if (isClosed) return;
        updateResult.fold(
          (error) {
            if (!isClosed) emit(ProfileError(error));
          },
          (profile) {
            if (!isClosed) emit(AvatarUploaded(profile, 'Avatar updated successfully'));
          },
        );
      },
    );
  }

  // Soft delete account
  Future<void> deleteAccount() async {
    if (isClosed) return;
    emit(AccountDeleting());

    final result = await _usecase.softDeleteAccount();

    if (isClosed) return;
    result.fold(
      (error) => emit(ProfileError(error)),
      (message) => emit(AccountDeleted(message)),
    );
  }

  // Restore deleted account
  Future<void> restoreAccount() async {
    if (isClosed) return;
    emit(ProfileLoading());

    final result = await _usecase.restoreAccount();

    if (isClosed) return;
    result.fold(
      (error) => emit(ProfileError(error)),
      (message) => emit(AccountRestored(message)),
    );
  }

  // Sign out
  Future<void> signOut() async {
    if (isClosed) return;
    emit(ProfileLoading());

    final result = await _usecase.signOut();

    if (isClosed) return;
    result.fold(
      (error) => emit(ProfileError(error)),
      (_) => emit(SignedOut()),
    );
  }

  // Method to load country codes from JSON
  Future<List<CountryCodeEntity>> _loadCountryCodes() async {
    final String response = await rootBundle.loadString(
      'Assets/jsons/country_code.json',
    );
    final List<dynamic> data = json.decode(response);
    return data.map((json) => CountryCodeEntity.fromJson(json)).toList();
  }

  // Method to change phone number type and extract country code
  Future<Map<String, String>> _parsePhoneNumber(String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return {
        'phoneCountryCode': 'sa',
        'dialCode': '+966',
        'localNumber': '',
      };
    }

    // Load country codes
    final countryCodes = await _loadCountryCodes();

    // Sort by dial code length (descending) to match longer codes first
    final sortedCodes = List<CountryCodeEntity>.from(countryCodes)
      ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));

    // Try to match the phone number with dial codes
    for (final country in sortedCodes) {
      final dialCodeWithoutPlus = country.dialCode.replaceAll('+', '');
      if (phoneNumber.startsWith(dialCodeWithoutPlus)) {
        return {
          'phoneCountryCode': country.code,
          'dialCode': country.dialCode,
          'localNumber': phoneNumber.substring(dialCodeWithoutPlus.length),
        };
      }
    }

    // If no match found, default to Saudi Arabia
    return {
      'phoneCountryCode': 'sa',
      'dialCode': '+966',
      'localNumber': phoneNumber,
    };
  }

  // Initialize form for editing with current profile data
  Future<void> initializeFormForEditing(ProfileEntity profile) async {
    // Change phone number type to extract country code and local number
    final parsedPhone = await _parsePhoneNumber(profile.phoneNumber);

    if (isClosed) return;
    emit(ProfileFormState(
      fullName: profile.fullName,
      originalFullName: profile.fullName,
      username: profile.username,
      email: profile.email,
      phoneNumber: parsedPhone['localNumber'] ?? '',
      phoneCountryCode: parsedPhone['phoneCountryCode'] ?? 'sa',
      dialCode: parsedPhone['dialCode'] ?? '+966',
      address: profile.address ?? '',
      nationality: profile.nationality,
      gender: profile.gender,
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
        case 'email':
          newState = currentState.copyWith(email: value);
          break;
        case 'phoneNumber':
          newState = currentState.copyWith(phoneNumber: value);
          break;
        case 'address':
          newState = currentState.copyWith(address: value);
          break;
        case 'phoneCountryCode':
          newState = currentState.copyWith(phoneCountryCode: value);
          break;
        case 'dialCode':
          newState = currentState.copyWith(dialCode: value);
          break;
        default:
          return;
      }

      emit(newState);
    }
  }

  // Update nationality dropdown
  void updateNationality(String? nationality) {
    if (state is ProfileFormState) {
      final currentState = state as ProfileFormState;
      emit(currentState.copyWith(nationality: nationality));
    }
  }

  // Update gender dropdown
  void updateGender(String? gender) {
    if (state is ProfileFormState) {
      final currentState = state as ProfileFormState;
      emit(currentState.copyWith(gender: gender));
    }
  }

  // Validate and submit the form
  Future<void> validateAndSubmitForm(String dialCode) async {
    if (state is! ProfileFormState) return;

    final formState = state as ProfileFormState;
    final errors = <String, String>{};

    // Full name validation
    if (formState.fullName.trim().isEmpty) {
      errors['fullName'] = 'Full name is required';
    } else {
      final nameParts = formState.fullName.trim().split(RegExp(r'\s+'));

      if (nameParts.length < 2 || nameParts.length > 3) {
        errors['fullName'] = 'Full name must be 2-3 names';
      } else {
        final originalHasNumbers = RegExp(r'\d').hasMatch(formState.originalFullName);
        final currentHasNumbers = RegExp(r'\d').hasMatch(formState.fullName);

        if (currentHasNumbers && !originalHasNumbers) {
          errors['fullName'] = 'Full name cannot contain numbers';
        }
      }
    }

    if (formState.username.trim().isEmpty) {
      errors['username'] = 'Username is required';
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(formState.username)) { // We might change this later on, but this what I think suits our cases
      errors['username'] = 'Username can only contain letters, numbers, and underscores';
    }

    // Email validation
    if (formState.email.trim().isEmpty) {
      errors['email'] = 'Email is required';
    } else {
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]{3,}@[a-zA-Z0-9.-]{3,}\.[a-zA-Z]{1,}$');

      if (!formState.email.contains('@')) {
        errors['email'] = 'Email must include @';
      } else if (!formState.email.contains('.')) {
        errors['email'] = 'Email must include .';
      } else if (!emailRegex.hasMatch(formState.email.trim())) {
        errors['email'] = 'Email format: (3+)@(3+).(1+)';
      }
    }

    // Phone number validation
    if (formState.phoneNumber.trim().isEmpty) {
      errors['phoneNumber'] = 'Phone number is required';
    } else {
      final phoneDigitsOnly = formState.phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

      if (RegExp(r'[a-zA-Z]').hasMatch(formState.phoneNumber)) {
        errors['phoneNumber'] = 'Phone cannot contain letters';
      } else if (phoneDigitsOnly.length < 6 || phoneDigitsOnly.length > 13) {
        errors['phoneNumber'] = 'Phone must be 6-13 digits';
      }
    }

    if (formState.nationality == null) {
      errors['nationality'] = 'Nationality is required';
    }

    if (formState.gender == null) {
      errors['gender'] = 'Gender is required';
    }

    if (errors.isNotEmpty) {
      if (isClosed) return;
      emit(formState.copyWith(validationErrors: errors));
      return;
    }

    // Clear errors and set submitting state
    if (isClosed) return;
    emit(formState.copyWith(validationErrors: {}, isSubmitting: true));

    // Remove "+" sign from countries ("+966" e.g.)
    final fullPhoneNumber = dialCode.replaceAll('+', '') + formState.phoneNumber.trim();

    // Submit the update
    final result = await _usecase.updateProfile(
      username: formState.username.trim(),
      fullName: formState.fullName.trim(),
      email: formState.email.trim(),
      phoneNumber: fullPhoneNumber,
      address: formState.address.trim().isEmpty ? null : formState.address.trim(),
      gender: formState.gender,
      nationality: formState.nationality,
    );

    if (isClosed) return;
    result.fold(
      (error) => emit(ProfileError(error)),
      (profile) => emit(ProfileUpdated(profile, 'Profile updated successfully')),
    );
  }
}
