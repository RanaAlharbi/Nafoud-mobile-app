import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';
import 'package:final_project/features/events_test/domain_layer/entity/events_entity.dart';

abstract class EventsDomainRepostiory {
  Future<List<EventEntity>> getEvents();
}