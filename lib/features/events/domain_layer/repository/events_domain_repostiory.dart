import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';

// Abstract repository interface for events domain layer
// Defines the contract for events data operations
abstract class EventsDomainRepository {
  // Fetches all events
  Future<List<EventEntity>> getEvents();
}