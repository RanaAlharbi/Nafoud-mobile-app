import 'package:equatable/equatable.dart';

class AuthenticationEntity extends Equatable {
  final String accessToken;
  final String refreshToken;

  const AuthenticationEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
