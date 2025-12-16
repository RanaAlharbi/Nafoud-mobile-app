import 'package:equatable/equatable.dart';
import 'package:final_project/features/my_activity/domain/entities/my_activity_entity.dart';

abstract class MyActivityState extends Equatable {
  const MyActivityState();

  @override
  List<Object?> get props => [];
}

class MyActivityInitialState extends MyActivityState {}

class MyActivityLoadingState extends MyActivityState {}

class MyActivitySuccessState extends MyActivityState {
  final MyActivityEntity activity;
  const MyActivitySuccessState(this.activity);

  @override
  List<Object?> get props => [activity];
}

class MyActivityErrorState extends MyActivityState {
  final String message;
  const MyActivityErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

