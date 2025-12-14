import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseBookmarkDataSource {
  Future<List<String>> getUserBookmarks();
  Future<void> addBookmark(String eventId);
  Future<void> removeBookmark(String eventId);
  Future<List<GatheringEntity>> getEventsByIds(List<String> ids);
}

@LazySingleton(as: BaseBookmarkDataSource)
class BookmarkRemoteDataSource implements BaseBookmarkDataSource {
  final SupabaseClient _supabase;

  BookmarkRemoteDataSource(this._supabase);

  @override
  Future<List<GatheringEntity>> getEventsByIds(List<String> ids) async {
    if (ids.isEmpty) return [];

    final response = await _supabase
        .from("user_events")
        .select()
        .inFilter("id", ids); 

    return (response as List)
        .map((e) => GatheringModelMapper.fromMap(e))
        .toList();
  }

  @override
  Future<List<String>> getUserBookmarks() async {
    final userId = _supabase.auth.currentUser!.id;

    final response = await _supabase
        .from("bookmarks")
        .select("event_id")
        .eq("user_id", userId);

    return (response as List).map((e) => e["event_id"] as String).toList();
  }

  @override
  Future<void> addBookmark(String eventId) async {
    final userId = _supabase.auth.currentUser!.id;

    await _supabase.from("bookmarks").insert({
      "user_id": userId,
      "event_id": eventId,
      "created_at": DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<void> removeBookmark(String eventId) async {
    final userId = _supabase.auth.currentUser!.id;

    await _supabase
        .from("bookmarks")
        .delete()
        .eq("user_id", userId)
        .eq("event_id", eventId);
  }
}
