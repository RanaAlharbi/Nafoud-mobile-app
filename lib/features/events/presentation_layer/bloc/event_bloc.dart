import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';
import 'package:final_project/features/events/domain_layer/usecase/events_usecase.dart';
import 'package:injectable/injectable.dart';

part 'event_event.dart';
part 'event_state.dart';

// Bloc for managing Events state
// Handles all business logic related to events feature
@injectable
class EventBloc extends Bloc<EventEvent, EventState> {
  final GetEventsUsecase _getEventsUsecase;

  EventBloc(this._getEventsUsecase) : super(EventInitial()) {
    // Register event handlers
    on<LoadEventsEvent>(_onLoadEvents);
    on<RefreshEventsEvent>(_onRefreshEvents);
  }

  // Handler for LoadEventsEvent
  Future<void> _onLoadEvents(
    LoadEventsEvent event,
    Emitter<EventState> emit,
  ) async {
    // Skip loading if events are already loaded and not forcing refresh
    if (!event.forceRefresh && state is LoadedEvents) {
      return;
    }

    emit(LoadingEvents());

    try {
      final events = await _getEventsUsecase();
      emit(LoadedEvents(events));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }

  // Handler for RefreshEventsEvent
  Future<void> _onRefreshEvents(
    RefreshEventsEvent event,
    Emitter<EventState> emit,
  ) async {
    emit(LoadingEvents());

    try {
      final events = await _getEventsUsecase();
      emit(LoadedEvents(events));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }
}
