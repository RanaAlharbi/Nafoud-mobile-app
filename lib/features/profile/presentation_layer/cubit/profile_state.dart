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
