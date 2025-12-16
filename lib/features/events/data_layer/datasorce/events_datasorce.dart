import 'package:final_project/features/events/data_layer/model/events_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Abstract base class for events remote data source
// Defines the contract for fetching events from remote API
abstract class BaseEventsRemoteDatasource {
  // Fetches all events from the remote data source
  Future<List<EventModel>> getEvents();
}

// Implementation of [BaseEventsRemoteDatasource] using Supabase
// Handles all remote data operations for events
@LazySingleton(as: BaseEventsRemoteDatasource)
class EventsRemoteDatasource implements BaseEventsRemoteDatasource {
  final SupabaseClient supabase;

  EventsRemoteDatasource(this.supabase);

  @override
  Future<List<EventModel>> getEvents() async {
    try {
      final response = await supabase.from('events').select();

      return (response as List)
          .map((e) => EventModelMapper.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch events: $e');
    }
  }
}