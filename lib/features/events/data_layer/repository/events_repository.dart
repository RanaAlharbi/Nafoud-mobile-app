import 'package:final_project/features/events/data_layer/datasorce/events_datasorce.dart';
import 'package:final_project/features/events/data_layer/model/events_model.dart';
import 'package:final_project/features/events/domain_layer/repository/events_domain_repostiory.dart';
import 'package:final_project/features/events_test/domain_layer/entity/events_entity.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: EventsDomainRepostiory)
class EventsRepositoryData implements EventsDomainRepostiory {
  final BaseEventsRemoteDatasource datasource;

  EventsRepositoryData(this.datasource);
  @override
  Future<List<EventModel>> getEvents() async{
  return  await  datasource.getEvents();
  }

}