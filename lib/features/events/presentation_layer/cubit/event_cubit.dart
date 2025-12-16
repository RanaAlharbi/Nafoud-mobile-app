import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';
import 'package:final_project/features/events/domain_layer/usecase/events_usecase.dart';
import 'package:injectable/injectable.dart';

part 'event_state.dart';


@injectable
class EventCubit extends Cubit<EventState> {
  final GetEventsUsecase _usecase;

  EventCubit(this._usecase) : super(EventInitial());

  Future<void> loadedEvents({bool forceRefresh = false}) async{
    // Skip loading if events are already loaded and not forcing refresh
    if (!forceRefresh && state is LoadedEvents) {
      return;
    }

    emit(LoadingEvents());

    try{
      final events = await _usecase();
      emit(LoadedEvents(events));

    }
    catch(e){
    emit(EventsError(e.toString()));
    }
  }
}
