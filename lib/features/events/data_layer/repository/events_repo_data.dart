import 'package:final_project/features/events/data_layer/datasource/events_datasource.dart';
import 'package:final_project/features/events/data_layer/model/events_model.dart';
import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';
import 'package:final_project/features/events/domain_layer/repository/events_repository.dart';

class EventsRepoData implements EventRepositoryDomain {

  final BaseEventsDatasource _baseEventsDatasource;

  EventsRepoData(this._baseEventsDatasource);

  @override
  Future<List<EventsModel>> generateEventsByAI() async {
    return await _baseEventsDatasource.generateEventsByAI();
  }

  @override
  Future<List<EventsModel>> getEvents() async {
    return await _baseEventsDatasource.getEvents();
  }

@override
Future<void> saveEvent(EventEntity event) async {
  if (event is EventsModel) {
    await _baseEventsDatasource.saveEvent(event);
  } else {
    throw Exception();
  }
}


}