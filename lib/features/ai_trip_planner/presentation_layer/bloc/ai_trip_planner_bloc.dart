import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/features/ai_trip_planner/domain_layer/entity/ai_trip_entity.dart';
import 'package:final_project/features/ai_trip_planner/domain_layer/usecase/ai_trip_usecase.dart';

part 'ai_trip_planner_event.dart';
part 'ai_trip_planner_state.dart';

class TripPlannerBloc extends Bloc<TripPlannerEvent, TripPlannerState> {
  final GenerateTripUseCase _generateTrip;
  TripPlannerBloc(this._generateTrip) : super(const TripPlannerState()) {
    on<TripStepChanged>((event, emit) {
      emit(state.copyWith(currentStep: event.stepIndex));
    });

    on<TripPreferencesUpdated>((event, emit) {
      emit(state.copyWith(preferences: event.preferences));
    });

    on<TripPlanSubmitted>(_onPlanSubmitted);
  }

  Future<void> _onPlanSubmitted(
    TripPlanSubmitted event,
    Emitter<TripPlannerState> emit,
  ) async {
    emit(state.copyWith(status: TripStatus.loading));

    try {
      final response = await _generateTrip.call(state.preferences);

      emit(state.copyWith(status: TripStatus.success, aiResponse: response));
    } catch (e) {
      emit(state.copyWith(status: TripStatus.error));
    }
  }
}
