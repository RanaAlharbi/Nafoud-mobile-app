part of 'ai_trip_planner_bloc.dart';

sealed class TripPlannerEvent extends Equatable {
  const TripPlannerEvent();

  @override
  List<Object> get props => [];
}

class TripStepChanged extends TripPlannerEvent {
  final int stepIndex;
  const TripStepChanged(this.stepIndex);
  @override
  List<Object> get props => [stepIndex];
}

class TripPreferencesUpdated extends TripPlannerEvent {
  final TripEntity preferences;
  const TripPreferencesUpdated(this.preferences);
  @override
  List<Object> get props => [preferences];
}

class TripPlanSubmitted extends TripPlannerEvent {}
