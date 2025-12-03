part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class SignUpSubmitted extends AuthenticationEvent {
  final String username;
  final String email;
  final String password;

  const SignUpSubmitted({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, password];
}

class SignInSubmitted extends AuthenticationEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const SignInSubmitted({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
}

class ResetPasswordEmailRequested extends AuthenticationEvent {
  final String email;

  const ResetPasswordEmailRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class UpdatePasswordSubmitted extends AuthenticationEvent {
  final String email;
  final String code;
  final String newPassword;

  const UpdatePasswordSubmitted({
    required this.email,
    required this.code,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [email, code, newPassword];
}

class VerifyEmailSubmitted extends AuthenticationEvent {
  final String email;
  final String otp;

  const VerifyEmailSubmitted({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}
