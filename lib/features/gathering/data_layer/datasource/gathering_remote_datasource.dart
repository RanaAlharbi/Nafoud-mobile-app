import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart'; //multiple result package
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseGatheringRemoteDataSource {
  //all methods
  Future<Result<List<GatheringModel>, String>> getAllEvents({String? category});
  Future<Result<void, String>> createUserEvent(GatheringModel event);
  Future<Result<void, String>> deleteUserEvent(String id, String userId);
  Future<Result<List<GatheringModel>, String>> searchEvents(String keyword);
  Future<Result<List<GatheringModel>, String>> getEventsForMap();
  Future<Result<void, String>> addBookmark(String eventId);
  Future<Result<void, String>> removeBookmark(String eventId);
}

@LazySingleton(as: BaseGatheringRemoteDataSource)
class GatheringRemoteDataSource implements BaseGatheringRemoteDataSource {
  final SupabaseClient _supabase;

  GatheringRemoteDataSource(this._supabase);

  //override methods
  @override
  Future<Result<void, String>> createUserEvent(GatheringModel event) async {
    try {
      await _supabase.from('user_events').insert(event.toMap());
      return Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<void, String>> deleteUserEvent(String id, String userId) async {
    try {
      await _supabase
          .from('user_events')
          .delete()
          .eq('id', id)
          .eq('user_id', userId);
      return Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<List<GatheringModel>, String>> getAllEvents({
    String? category,
  }) async {
    try {
      var query = _supabase.from('user_events').select('*');

      if (category != null && category != "All") {
        query = query.eq('category', category);
      }

      final response = await query.order('date', ascending: false);

      final events = (response as List)
          .map((e) => GatheringModelMapper.fromMap(e))
          .toList();

      return Success(events);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<List<GatheringModel>, String>> searchEvents(
    String keyword,
  ) async {
    try {
      final response = await _supabase
          .from('user_events')
          .select('*')
          .ilike('title', '%$keyword%');

      final events = (response as List)
          .map((e) => GatheringModelMapper.fromMap(e))
          .toList();

      return Success(events);
    } catch (e) {
      return Error(e.toString());
    }
  }

@override
  Future<Result<List<GatheringModel>, String>> getEventsForMap() async {
    try {
      final response = await _supabase
          .from('user_events')
          .select('*')
          .not('latitude', 'is', null)
          .not('longitude', 'is', null);

      final events = (response as List)
          .map((e) => GatheringModelMapper.fromMap(e))
          .toList();

      return Success(events);
    } catch (e) {
      return Error(e.toString());
    }
  }

  
  @override
  Future<Result<void, String>> addBookmark(String eventId) async {
    try {
      final userId = _supabase.auth.currentUser!.id;

      await _supabase.from("bookmarks").insert({
        "user_id": userId,
        "event_id": eventId,
      });

      return const Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<void, String>> removeBookmark(String eventId) async {
    try {
      final userId = _supabase.auth.currentUser!.id;

      await _supabase.from("bookmarks").delete().match({
        "user_id": userId,
        "event_id": eventId,
      });

      return const Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }


  
}
