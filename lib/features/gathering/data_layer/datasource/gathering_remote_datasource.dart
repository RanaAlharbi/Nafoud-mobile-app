import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/gathering_model.dart';

abstract class BaseGatheringRemoteDataSource {
  Future<List<GatheringModel>> getAllEvents();
  Future<void> createUserEvent(GatheringModel event);
  Future<void> deleteUserEvent(String id, String userId);
}

class GatheringRemoteDataSource implements BaseGatheringRemoteDataSource {
  final SupabaseClient _supabase;

  GatheringRemoteDataSource(this._supabase);

  @override
  Future<void> createUserEvent(GatheringModel event) async {
    await _supabase.from('user_events').insert(event.toMap());
  }

  @override
  Future<void> deleteUserEvent(String id, String userId) async {
    await _supabase
        .from('user_events')
        .delete()
        .eq('id', id)
        .eq('user_id', userId);
  }

  @override
  Future<List<GatheringModel>> getAllEvents() async {
    final response= await _supabase
        .from('user_events')
        .select('*')
        .order('date', ascending: false); //order by date desending

    return (response as List)
        .map((e) => GatheringModelMapper.fromMap(e))
        .toList();
  }
}
