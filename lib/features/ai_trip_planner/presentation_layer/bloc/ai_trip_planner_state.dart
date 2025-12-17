part of 'ai_trip_planner_bloc.dart';

enum TripStatus { initial, loading, success, error }

class TripPlannerState extends Equatable {
  final TripStatus status;
  // Which step on the stepper I'm currently in 
  final int currentStep;
  final TripEntity preferences;
  final String? aiResponse;

  const TripPlannerState({
    this.status = TripStatus.initial,
    this.currentStep = 0,
    this.preferences = const TripEntity(),
    this.aiResponse,
  });

  TripPlannerState copyWith({
    TripStatus? status,
    int? currentStep,
    TripEntity? preferences,
    String? aiResponse,
  }) {
    return TripPlannerState(
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      preferences: preferences ?? this.preferences,
      aiResponse: aiResponse ?? this.aiResponse,
    );
  }

  @override
  List<Object?> get props => [status, currentStep, preferences, aiResponse];
}
