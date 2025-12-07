part of 'gathering_cubit.dart';

abstract class GatheringState extends Equatable {
  const GatheringState();

  @override
  List<Object?> get props => [];
}

class GatheringInitial extends GatheringState {}

class GatheringLoading extends GatheringState {}

class GatheringLoaded extends GatheringState {
  final List events;

  const GatheringLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class GatheringError extends GatheringState {
  final String message;

  const GatheringError(this.message);

  @override
  List<Object?> get props => [message];
}
