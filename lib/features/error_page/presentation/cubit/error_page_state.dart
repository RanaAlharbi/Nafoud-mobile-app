import 'package:equatable/equatable.dart';

abstract class ErrorPageState extends Equatable {
  const ErrorPageState();

  @override
  List<Object?> get props => [];
}

class ErrorPageInitialState extends ErrorPageState {}

class ErrorPageLoadingState extends ErrorPageState {}

class ErrorPageSuccessState extends ErrorPageState {}

class ErrorPageLoadedState extends ErrorPageState {}

class ErrorPageErrorState extends ErrorPageState {
  final String message;
  const ErrorPageErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class ErrorPageSignedOutState extends ErrorPageState {}

