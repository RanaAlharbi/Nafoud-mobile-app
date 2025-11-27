part of 'profile_cubit.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;
  const ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final ProfileEntity profile;
  final String message;
  const ProfileUpdated(this.profile, this.message);
}

class AvatarUploading extends ProfileState {}

class AvatarUploaded extends ProfileState {
  final ProfileEntity profile;
  final String message;
  const AvatarUploaded(this.profile, this.message);
}

class AccountDeleting extends ProfileState {}

class AccountDeleted extends ProfileState {
  final String message;
  const AccountDeleted(this.message);
}

class AccountRestored extends ProfileState {
  final String message;
  const AccountRestored(this.message);
}

class SignedOut extends ProfileState {}

// State for managing edit profile form
class ProfileFormState extends ProfileState {
  final String fullName;
  final String username;
  final String email;
  final String phoneNumber;
  final String address;
  final String? selectedCountry;
  final String? selectedCountryCode;
  final String? selectedGenre;
  final Map<String, String> validationErrors;
  final bool isSubmitting;

  const ProfileFormState({
    required this.fullName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.address = '',
    this.selectedCountry,
    this.selectedCountryCode = 'sa',
    this.selectedGenre,
    this.validationErrors = const {},
    this.isSubmitting = false,
  });

  ProfileFormState copyWith({
    String? fullName,
    String? username,
    String? email,
    String? phoneNumber,
    String? address,
    String? selectedCountry,
    String? selectedCountryCode,
    String? selectedGenre,
    Map<String, String>? validationErrors,
    bool? isSubmitting,
  }) {
    return ProfileFormState(
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      selectedGenre: selectedGenre ?? this.selectedGenre,
      validationErrors: validationErrors ?? this.validationErrors,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
