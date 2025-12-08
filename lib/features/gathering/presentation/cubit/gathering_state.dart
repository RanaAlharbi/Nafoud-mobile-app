part of 'gathering_cubit.dart';

abstract class GatheringState extends Equatable {
  const GatheringState();

  @override
  List<Object?> get props => [];
}

class GatheringInitial extends GatheringState {}

class GatheringLoading extends GatheringState {}

class GatheringLoadingWithCategory extends GatheringState {
  final String selectedCategory;

  const GatheringLoadingWithCategory(this.selectedCategory);

  @override
  List<Object?> get props => [selectedCategory];
}


class GatheringLoaded extends GatheringState {
  final List events;
  final String selectedCategory;

  const GatheringLoaded(this.events, {this.selectedCategory = 'All'});

  @override
  List<Object?> get props => [events, selectedCategory];
}


class GatheringError extends GatheringState {
  final String message;

  const GatheringError(this.message);

  @override
  List<Object?> get props => [message];
}
