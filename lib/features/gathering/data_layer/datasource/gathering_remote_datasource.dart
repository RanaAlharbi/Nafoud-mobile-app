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

  /*Fetches all events from the 'user_events' table
  if a category is provided, the query is filtered by category.
  Returns a list of events on success, or an error message.*/

  @override
  Future<Result<List<GatheringModel>, String>> getAllEvents({
    String? category,
  }) async {
    try {
      var query = _supabase
          .from('user_events')
          .select('*'); //all events from table

      if (category != null && category != "All") {
        query = query.eq('category', category);
      }

      final response = await query.order(
        'date',
        ascending: false,
      ); //order events descending

      final events =
          (response as List) //list of events
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

      return Success(events); //return list of events if success
    } catch (e) {
      return Error(e.toString()); //return error message if wrong
    }
  }

  /* insert a new event into the 'user_events' table
the 'id' field is removed because Supabase auto-generates it- no need to add it so i removed it 
*/
  @override
  Future<Result<void, String>> createUserEvent(GatheringModel event) async {
    try {
      await _supabase
          .from('user_events')
          .insert(
            event.toMap()..remove('id'),
          ); // cascade operator remove id from it

      return Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }

  //I might need it --------------go back here (!) important don't forget about it--------------------
  // deletes user-owned event from the database
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

  // Returns events whose titles contain the search keyword for used in search bar
  @override
  Future<Result<List<GatheringModel>, String>> searchEvents(
    String keyword,
  ) async {
    try {
      final response = await _supabase
          .from('user_events')
          .select('*')
          .ilike('title', '%$keyword%'); //look for the keyword in title column
      //important notes
      //ilike is case-insensitive doesn't need toLowerCase()

      //return the event with the keyword
      final events = (response as List)
          .map((e) => GatheringModelMapper.fromMap(e))
          .toList();

      return Success(events);
    } catch (e) {
      return Error(e.toString());
    }
  }

  //return events with map-method used for displaying events on the map
  @override
  Future<Result<List<GatheringModel>, String>> getEventsForMap() async {
    try {
      final response = await _supabase
          .from('user_events')
          .select('*')
          .not(
            'latitude',
            'is',
            null,
          ) // Filters out events without latitude value
          .not(
            'longitude',
            'is',
            null,
          ); // Filters out events without longitude value

      final events =
          (response as List) //list of events
              .map((e) => GatheringModelMapper.fromMap(e))
              .toList();

      return Success(events);
    } catch (e) {
      return Error(e.toString());
    }
  }

//needs it in profile screen 
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

// Adds a bookmark - linked to user 
  @override
  Future<Result<void, String>> addBookmark(String eventId) async {
    try {
      final userId = _supabase.auth.currentUser!.id;

      await _supabase
      .from("bookmarks")
      .insert({
      "user_id": userId, //like it to a user
      "event_id": eventId,
      });

      return const Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }

// Removes a bookmark from the bookmarks table
  @override
  Future<Result<void, String>> removeBookmark(String eventId) async {
    try {
      final userId = _supabase.auth.currentUser!.id;

      await _supabase
      .from("bookmarks")
      .delete()
      .match({
        "user_id": userId,
        "event_id": eventId,
      });

      return const Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }


 //Uploads image to Supabase
  @override
  Future<Result<String, String>> uploadImage(String filePath) async {
    try {
      final file = File(filePath); // Convert file path into a File object for uploading
      final ext = file.path.split('.').last; // Extract file extension (jpg, png,....)
      final fileName = "${DateTime.now().millisecondsSinceEpoch}.$ext"; // Generate a unique filename 
      
      // events bucket in Supabase storage
      final bucket = _supabase.storage.from("events");
      
      // Upload to Supabase bucket
      await bucket.upload(
        fileName,
        file,
        fileOptions: const FileOptions(upsert: true), // upsert allows overwriting if it is needed
      );

      // retrieve URL for the file so it can be displayed in the ui
      final publicUrl = bucket.getPublicUrl(fileName);

      return Success(publicUrl);
    } catch (e) {
      return Error(e.toString());
    }
  }


// Adding current user as a participant in an event - if he click on joining button
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


// Retrieves avatar of the participants of specific event
  @override
  Future<Result<List<String>, String>> getParticipants(String eventId) async {
    try {
      final response = await _supabase
          .from("event_participants")
          .select("profiles(avatar_url)") // avatar_url fro profiles table--FK relation
          .eq("event_id", eventId);

      final avatars = <String>[]; // to store avatar images

      for (final row in response as List) {
        final profile = row["profiles"];

        if (profile != null && profile["avatar_url"] != null) {
          avatars.add(profile["avatar_url"]);
        } else {
          //if there is no image put image placeholder
          avatars.add("https://cdn.vectorstock.com/i/500p/66/69/default-profile-picture-avatar-photo-placeholder-vector-32286669.jpg");
        }
      }

      return Success(avatars);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
