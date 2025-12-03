import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';
import 'package:final_project/features/events/domain_layer/repository/events_domain_repostiory.dart';
import 'package:final_project/features/events_test/domain_layer/entity/events_entity.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class EventsUsecase {
  final EventsDomainRepostiory repository;

  EventsUsecase(this.repository);

  Future<List<EventEntity>> call() async {
    return await repository.getEvents();
  }
}
