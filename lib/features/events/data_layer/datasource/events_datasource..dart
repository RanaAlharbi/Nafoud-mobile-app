import 'dart:convert';
import 'package:final_project/features/events/data_layer/model/events_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


abstract class BaseEventsDatasource {
  Future<List<EventsModel>> getEvents();
  Future<void> saveEvent(EventsModel event);
  Future<List<EventsModel>> generateEventsByAI();
}

class EventsDatasource implements BaseEventsDatasource {
  final SupabaseClient _supabase;
  final GenerativeModel _aiModel;

  EventsDatasource(this._aiModel, this._supabase);

  @override
  Future<List<EventsModel>> getEvents() async {
    final response = await _supabase.from('events').select('*');

    return (response as List)
        .map((e) => EventsModelMapper.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveEvent(EventsModel event) async {
    await _supabase.from('events').insert(event.toJson());
  }

  @override
  Future<List<EventsModel>> generateEventsByAI() async {
    final prompt =
        "Generate upcoming Saudi events as JSON List with id, title, description, location, date";
    final result = await _aiModel.generateContent([Content.text(prompt)]);
    final decoded = jsonDecode(result.text ?? "[]") as List;
    return decoded
        .map((e) => EventsModelMapper.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
