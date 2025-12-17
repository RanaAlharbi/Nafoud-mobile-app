part of 'ai_trip_planner_bloc.dart';

enum TripStatus { initial, loading, success, error }

class TripPlannerState extends Equatable {
  final TripStatus status; 
  final int currentStep;
  final TripEntity preferences;
  final LlmProvider? aiProvider; 

  const TripPlannerState({
    this.status = TripStatus.initial,
    this.currentStep = 0,
    this.preferences = const TripEntity(),
    this.aiProvider,
  });

  TripPlannerState copyWith({
    TripStatus? status,
    int? currentStep,
    TripEntity? preferences,
    LlmProvider? aiProvider,
  }) {
    return TripPlannerState(
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      preferences: preferences ?? this.preferences,
      aiProvider: aiProvider ?? this.aiProvider,
    );
  }

  @override
  List<Object?> get props => [status, currentStep, preferences, aiProvider];
}