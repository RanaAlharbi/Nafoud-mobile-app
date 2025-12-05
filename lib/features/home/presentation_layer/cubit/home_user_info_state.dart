part of 'home_user_info_cubit.dart';

abstract class HomeUserInfoState extends Equatable {
  const HomeUserInfoState();

  @override
  List<Object?> get props => [];
}

class HomeUserInfoInitial extends HomeUserInfoState {}

class HomeUserInfoLoaded extends HomeUserInfoState {
  final String fullName;
  final String? avatarUrl;

  const HomeUserInfoLoaded({
    required this.fullName,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [fullName, avatarUrl];
}
