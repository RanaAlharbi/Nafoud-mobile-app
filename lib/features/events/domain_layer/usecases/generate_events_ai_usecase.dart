import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';
import 'package:final_project/features/events/domain_layer/repository/events_repository.dart';

class GenerateEventsAiUsecase {
  final EventRepositoryDomain repository;

  GenerateEventsAiUsecase(this.repository);

  Future<List<EventEntity>> call() async{
    return repository.generateEventsByAI();
  }
}