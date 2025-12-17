import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/features/my_activity/data/models/my_activity_model.dart';
import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseMyActivityRemoteDataSource {
  Future<Either<String, MyActivityModel>> getMyActivity();
}

@LazySingleton(as: BaseMyActivityRemoteDataSource)
class MyActivityRemoteDataSource implements BaseMyActivityRemoteDataSource {
  final SupabaseClient _supabase;

  MyActivityRemoteDataSource(this._supabase);

  @override
  Future<Either<String, MyActivityModel>> getMyActivity() async {
    try {
      // Get current user ID
      final userId = _supabase.auth.currentUser?.id;

      if (userId == null) {
        return const Left('User not authenticated');
      }

      // Step 1: Get event IDs from event_participants
      final participantsResponse = await _supabase
          .from('event_participants')
          .select('event_id')
          .eq('user_id', userId);

      final participatedEventIds = (participantsResponse as List)
          .map((e) => e['event_id'] as String)
          .toSet();

      // Step 2: Get events created by the user
      final createdEventsResponse = await _supabase
          .from('user_events')
          .select('*')
          .eq('user_id', userId);

      final createdEvents = (createdEventsResponse as List).map((eventData) {
        return GatheringModel(
          id: eventData['id'] as String,
          userId: eventData['user_id'] as String,
          title: eventData['title'] as String,
          description: eventData['description'] as String,
          city: eventData['city'] as String,
          date: eventData['date'] as String,
          eventTime: eventData['event_time'] as String,
          address: eventData['address'] as String,
          imageUrl: eventData['image_url'] as String,
          category: eventData['category'] as String,
          latitude: eventData['latitude'] as double?,
          longitude: eventData['longitude'] as double?,
        );
      }).toList();

      // Step 3: Get events user joined but didn't create
      final List<GatheringModel> joinedEvents = [];
      if (participatedEventIds.isNotEmpty) {
        final joinedEventsResponse = await _supabase
            .from('user_events')
            .select('*')
            .inFilter('id', participatedEventIds.toList())
            .neq('user_id', userId);

        joinedEvents.addAll(
          (joinedEventsResponse as List).map((eventData) {
            return GatheringModel(
              id: eventData['id'] as String,
              userId: eventData['user_id'] as String,
              title: eventData['title'] as String,
              description: eventData['description'] as String,
              city: eventData['city'] as String,
              date: eventData['date'] as String,
              eventTime: eventData['event_time'] as String,
              address: eventData['address'] as String,
              imageUrl: eventData['image_url'] as String,
              category: eventData['category'] as String,
              latitude: eventData['latitude'] as double?,
              longitude: eventData['longitude'] as double?,
            );
          }).toList(),
        );
      }

      // Combine both created and joined events
      final allEvents = [...createdEvents, ...joinedEvents];

      return Right(MyActivityModel(events: allEvents));
    } catch (error) {
      return Left('Failed to get activity: ${error.toString()}');
    }
  }
}
