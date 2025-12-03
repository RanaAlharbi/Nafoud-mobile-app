import 'package:final_project/features/events/data_layer/model/events_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseEventsRemoteDatasource {
  Future<List<EventModel>> getEvents();
}


@LazySingleton(as: BaseEventsRemoteDatasource )
class EventsRemoteDatasource  implements BaseEventsRemoteDatasource{
 final SupabaseClient supabase;

  EventsRemoteDatasource(this.supabase);

  

@override
Future<List<EventModel>> getEvents() async {
  final response = await supabase.from('events').select();

  return (response as List)
      .map((e) => EventModelMapper.fromMap(e as Map<String, dynamic>))
      .toList();
 }
}