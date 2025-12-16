import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';
import 'package:final_project/features/events/domain_layer/repository/events_domain_repostiory.dart';
import 'package:injectable/injectable.dart';

// Use case for fetching all events
// Encapsulates the business logic for retrieving events
@lazySingleton
class GetEventsUsecase {
  final EventsDomainRepository repository;

  GetEventsUsecase(this.repository);

  // Executes the use case to fetch all events
  Future<List<EventEntity>> call() async {
    return await repository.getEvents();
  }
}
