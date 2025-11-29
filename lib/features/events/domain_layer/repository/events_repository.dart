import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';

abstract class EventRepositoryDomain {
  
  // Returns all events stored in the data source
  Future<List<EventEntity>> getEvents();

  // Saves a new event to the supbaase
  Future<void> saveEvent(EventEntity event);

 //Genraate events using AI
  Future<List<EventEntity>> generateEventsByAI();

}