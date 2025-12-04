part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;
  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final ProfileEntity profile;
  final String message;
  const ProfileUpdated(this.profile, this.message);

  @override
  List<Object?> get props => [profile, message];
}

class AvatarUploading extends ProfileState {}

class AvatarUploaded extends ProfileState {
  final ProfileEntity profile;
  final String message;
  const AvatarUploaded(this.profile, this.message);

  @override
  List<Object?> get props => [profile, message];
}

class AccountDeleting extends ProfileState {}

class AccountDeleted extends ProfileState {
  final String message;
  const AccountDeleted(this.message);

  @override
  List<Object?> get props => [message];
}

class AccountRestored extends ProfileState {
  final String message;
  const AccountRestored(this.message);

  @override
  List<Object?> get props => [message];
}

class SignedOut extends ProfileState {}

// State for managing edit profile form
class ProfileFormState extends ProfileState {
  final String fullName;
  final String originalFullName; // Track original name to allow old accounts with numbers
  final String username;
  final String email;
  final String phoneNumber; // Just the local phone number (will be connected with country code on submit)
  final String phoneCountryCode; // Country code for phone (e.g., 'sa')
  final String dialCode; // (e.g., '+966') - temporary for form submission
  final String address;
  final String? nationality; // Nationality (country code)
  final String? gender;
  final Map<String, String> validationErrors;
  final bool isSubmitting;

  const ProfileFormState({
    required this.fullName,
    required this.originalFullName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.phoneCountryCode = 'sa',
    this.dialCode = '+966',
    this.address = '',
    this.nationality,
    this.gender,
    this.validationErrors = const {},
    this.isSubmitting = false,
  });

  @override
  List<Object?> get props => [
        fullName,
        originalFullName,
        username,
        email,
        phoneNumber,
        phoneCountryCode,
        dialCode,
        address,
        nationality,
        gender,
        validationErrors,
        isSubmitting,
      ];

  ProfileFormState copyWith({
    String? fullName,
    String? originalFullName,
    String? username,
    String? email,
    String? phoneNumber,
    String? phoneCountryCode,
    String? dialCode,
    String? address,
    String? nationality,
    String? gender,
    Map<String, String>? validationErrors,
    bool? isSubmitting,
  }) {
    return ProfileFormState(
      fullName: fullName ?? this.fullName,
      originalFullName: originalFullName ?? this.originalFullName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      dialCode: dialCode ?? this.dialCode,
      address: address ?? this.address,
      nationality: nationality ?? this.nationality,
      gender: gender ?? this.gender,
      validationErrors: validationErrors ?? this.validationErrors,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
