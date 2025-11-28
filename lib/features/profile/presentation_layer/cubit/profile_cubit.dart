import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // TEMPORARY: For test login
import '../../domain_layer/usecase/profile_usecase.dart';
import '../../domain_layer/entity/profile_entity.dart';
import '../../domain_layer/entity/country_code_entity.dart';

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
        email: 'testo@example.com',
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

    emit(ProfileFormState(
      fullName: profile.fullName,
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

    // Validation
    if (formState.fullName.trim().isEmpty) {
      errors['fullName'] = 'Full name is required';
    }

    if (formState.username.trim().isEmpty) {
      errors['username'] = 'Username is required';
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(formState.username)) {
      errors['username'] = 'Username can only contain letters, numbers, and underscores';
    }

    if (formState.phoneNumber.trim().isEmpty) {
      errors['phoneNumber'] = 'Phone number is required';
    }

    if (formState.nationality == null) {
      errors['nationality'] = 'Nationality is required';
    }

    if (formState.gender == null) {
      errors['gender'] = 'Gender is required';
    }

    if (errors.isNotEmpty) {
      emit(formState.copyWith(validationErrors: errors));
      return;
    }

    // Clear errors and set submitting state
    emit(formState.copyWith(validationErrors: {}, isSubmitting: true));

    // Remove "+" sign from countries (+966 e.g.)
    final fullPhoneNumber = dialCode.replaceAll('+', '') + formState.phoneNumber.trim();

    // Submit the update
    final result = await _usecase.updateProfile(
      username: formState.username.trim(),
      fullName: formState.fullName.trim(),
      phoneNumber: fullPhoneNumber,
      address: formState.address.trim().isEmpty ? null : formState.address.trim(),
      gender: formState.gender,
      nationality: formState.nationality,
    );

    result.fold(
      (error) => emit(ProfileError(error)),
      (profile) => emit(ProfileUpdated(profile, 'Profile updated successfully')),
    );
  }
}
