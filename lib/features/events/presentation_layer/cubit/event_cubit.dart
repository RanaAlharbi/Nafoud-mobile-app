import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';
import 'package:final_project/features/events/domain_layer/usecase/events_usecase.dart';
import 'package:injectable/injectable.dart';

part 'event_state.dart';

@injectable
class EventCubit extends Cubit<EventState> {
  final EventsUsecase _usecase;

  EventCubit(this._usecase) : super(EventInitial());

  Future<void> loadedEvents() async{
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
