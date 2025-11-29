
import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';
import 'package:final_project/features/events/domain_layer/repository/events_repository.dart';

class GetEventsUsecase {
  final EventRepositoryDomain repository;

  GetEventsUsecase(this.repository);

   Future<List<EventEntity>> call() async {
    return repository.getEvents();
  }

}