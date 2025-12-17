part of 'ai_trip_planner_bloc.dart';

sealed class TripPlannerEvent extends Equatable {
  const TripPlannerEvent();

  @override
  List<Object> get props => [];
}

// Which step I'm on 
class TripStepChanged extends TripPlannerEvent {
  final int stepIndex;
  const TripStepChanged(this.stepIndex);
  @override
  List<Object> get props => [stepIndex];
}

// Options in steps updated 
class TripPreferencesUpdated extends TripPlannerEvent {
  final TripEntity preferences;
  const TripPreferencesUpdated(this.preferences);
  @override
  List<Object> get props => [preferences];
}
// When user finishes selecting the options and submits 
class TripPlanSubmitted extends TripPlannerEvent {}
