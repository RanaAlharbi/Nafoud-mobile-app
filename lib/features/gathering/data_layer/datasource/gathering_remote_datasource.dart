import 'dart:io';
import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
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
  Future<Result<String, String>> uploadImage(String filePath);
  Future<Result<List<String>, String>> getUserBookmarks();
  Future<Result<void, String>> joinEvent(String eventId);
  Future<Result<List<String>, String>> getParticipants(String eventId);
}

@LazySingleton(as: BaseGatheringRemoteDataSource)
class GatheringRemoteDataSource implements BaseGatheringRemoteDataSource {
  final SupabaseClient _supabase;

  GatheringRemoteDataSource(this._supabase);

  //override methods
  @override
  Future<Result<void, String>> createUserEvent(GatheringModel event) async {
    try {
      await _supabase.from('user_events').insert(event.toMap()..remove('id'));

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
          .map(
            (e) => GatheringModel(
              id: e["id"],
              userId: e["user_id"],
              title: e["title"],
              description: e["description"],
              city: e["city"],
              date: e["date"],
              eventTime: e["event_time"],
              address: e["address"],
              imageUrl: e["image_url"],
              category: e["category"],
              latitude: e["latitude"],
              longitude: e["longitude"],
            ),
          )
          .toList();

      return Success(events);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<List<String>, String>> getUserBookmarks() async {
    try {
      final userId = _supabase.auth.currentUser!.id;
      final response = await _supabase
          .from("bookmarks")
          .select("event_id")
          .eq("user_id", userId);

      final ids = (response as List)
          .map((e) => e["event_id"] as String)
          .toList();

      return Success(ids);
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

  @override
  Future<Result<String, String>> uploadImage(String filePath) async {
    try {
      final file = File(filePath);
      final ext = file.path.split('.').last;
      final fileName = "${DateTime.now().millisecondsSinceEpoch}.$ext";

      final bucket = _supabase.storage.from("events");

      await bucket.upload(
        fileName,
        file,
        fileOptions: const FileOptions(upsert: true),
      );

      final publicUrl = bucket.getPublicUrl(fileName);

      return Success(publicUrl);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<void, String>> joinEvent(String eventId) async {
    try {
      final user = _supabase.auth.currentUser!;

      await _supabase.from("event_participants").upsert({
        "event_id": eventId,
        "user_id": user.id,
      }, onConflict: "event_id,user_id");

      return Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<List<String>, String>> getParticipants(String eventId) async {
    try {
      final res = await _supabase
          .from("event_participants")
          .select("profiles(avatar_url)")
          .eq("event_id", eventId);

      final avatars = <String>[];

      for (final row in res as List) {
        final profile = row["profiles"];

    
        if (profile != null && profile["avatar_url"] != null) {
          avatars.add(profile["avatar_url"]);
        } else {
          avatars.add("https://via.placeholder.com/150"); 
        }
      }

      return Success(avatars);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
