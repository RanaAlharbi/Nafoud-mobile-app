import 'package:final_project/features/events/data_layer/datasorce/events_datasorce.dart';
import 'package:final_project/features/events/data_layer/model/events_model.dart';
import 'package:final_project/features/events/domain_layer/repository/events_domain_repostiory.dart';
import 'package:injectable/injectable.dart';

// Data layer implementation of [EventsDomainRepository]
// Acts as a bridge between domain layer and data sources
@LazySingleton(as: EventsDomainRepository)
class EventsRepositoryData implements EventsDomainRepository {
  final BaseEventsRemoteDatasource datasource;

  EventsRepositoryData(this.datasource);

  @override
  Future<List<EventModel>> getEvents() async {
    return await datasource.getEvents();
  }
}