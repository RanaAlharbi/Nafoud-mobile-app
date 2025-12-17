import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/features/ai_trip_planner/domain_layer/entity/ai_trip_entity.dart';
import 'package:final_project/features/ai_trip_planner/domain_layer/usecase/ai_trip_usecase.dart';

part 'ai_trip_planner_event.dart';
part 'ai_trip_planner_state.dart';

class TripPlannerBloc extends Bloc<TripPlannerEvent, TripPlannerState> {
  final GenerateTripUseCase _generateTrip;
  TripPlannerBloc(this._generateTrip) : super(const TripPlannerState()) {
    // when the step is changed 
    on<TripStepChanged>((event, emit) {
      emit(state.copyWith(currentStep: event.stepIndex));
    });

    // When trip preferences (options) are updated 
    on<TripPreferencesUpdated>((event, emit) {
      emit(state.copyWith(preferences: event.preferences));
    });

    // When user submits their preferences 
    on<TripPlanSubmitted>(_onPlanSubmitted);
  }

  Future<void> _onPlanSubmitted(
    TripPlanSubmitted event,
    Emitter<TripPlannerState> emit,
  ) async {
    // load while generating response 
    emit(state.copyWith(status: TripStatus.loading));

    try {
      final response = await _generateTrip.call(state.preferences);
      // If successful, return the response 
      emit(state.copyWith(status: TripStatus.success, aiResponse: response));
    } catch (e) {
      // If not successful, return the error
      emit(state.copyWith(status: TripStatus.error));
    }
  }
}
