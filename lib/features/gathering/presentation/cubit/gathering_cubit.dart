import 'package:bloc/bloc.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/add_bookmark_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/get_participants_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/get_user_bookmark.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/join_event_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/remove_bookmark_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/upload_image_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/create_gathering_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/delete_gathering_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/get_gatherings_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/get_map_events_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/search_event_usecase.dart';
import 'gathering_state.dart';

@injectable
class GatheringCubit extends Cubit<GatheringState> {
  // form state
  String selectedCategory = "All";
  String? selectedImageUrl;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  double? selectedLat;
  double? selectedLng;

  // text fields
  String title = "";
  String description = "";
  String city = "";
  String address = "";

  // event categories
  final categories = const [
    "All",
    "Cultural",
    "Sports",
    "Arts",
    "Entertainment",
  ];

  // bookmarks
  List<String> userBookmarks = [];

  // participants
  List<String> participants = [];

  List<String> lastAvatars = [];
  bool isDescriptionExpanded = false;

  bool isUploadingImage = false;

  // use cases
  final GatheringUsecase getEventsUsecase;
  final CreateGatheringUseCase createGatheringUsecase;
  final DeleteGatheringUseCase deleteGatheringUsecase;
  final SearchEventsUseCase searchEventsUseCase;
  final GetMapEventsUseCase getMapEventsUseCase;
  final AddBookmarkUseCase addBookmark;
  final RemoveBookmarkUseCase removeBookmark;
  final UploadImageUseCase uploadImageUseCase;
  final GetUserBookmarkUsecase userBookmarkUsecase;
  final JoinEventUseCase joinEventUseCase;
  final GetParticipantsUseCase getParticipantsUseCase;

  GatheringCubit(
    this.getEventsUsecase,
    this.createGatheringUsecase,
    this.deleteGatheringUsecase,
    this.searchEventsUseCase,
    this.getMapEventsUseCase,
    this.addBookmark,
    this.removeBookmark,
    this.uploadImageUseCase,
    this.userBookmarkUsecase,
    this.joinEventUseCase,
    this.getParticipantsUseCase,
  ) : super(const GatheringInitial());

  // upload image
Future<void> uploadImage(String filePath) async {
  try {
    isUploadingImage = true;
    emit(GatheringLoading(selectedCategory: selectedCategory));

    final result = await uploadImageUseCase(filePath);

    result.when(
      (url) {
        selectedImageUrl = url;

        isUploadingImage = false;
        emit(
          GatheringFormUpdated(
            selectedCategory: selectedCategory,
            selectedImageUrl: selectedImageUrl,
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            selectedLat: selectedLat,
            selectedLng: selectedLng,
            isUploadingImage: isUploadingImage, // مهم جداً
          ),
        );
      },
      (err) {
        isUploadingImage = false;
        emit(
          GatheringError(
            message: err,
            selectedCategory: selectedCategory,
            isUploadingImage: isUploadingImage,
          ),
        );
      },
    );
  } catch (e) {
    isUploadingImage = false;
    emit(
      GatheringError(
        message: e.toString(),
        selectedCategory: selectedCategory,
        isUploadingImage: isUploadingImage,
      ),
    );
  }
}


  void updateField(String key, String value) {
    if (key == "title") title = value;
    if (key == "description") description = value;
    if (key == "city") city = value;
    if (key == "address") address = value;

    emit(
      GatheringFormUpdated(
        selectedCategory: selectedCategory,
        selectedImageUrl: selectedImageUrl,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        selectedLat: selectedLat,
        selectedLng: selectedLng,
      ),
    );
  }

  void resetForm() {
    selectedCategory = "All";
    selectedImageUrl = null;
    selectedDate = null;
    selectedTime = null;
    selectedLat = null;
    selectedLng = null;

    title = "";
    description = "";
    city = "";
    address = "";

    emit(GatheringInitial());
  }

  // Updates map position before confirming using done button
  void updateTempLocation(double lat, double lng) {
    selectedLat = lat;
    selectedLng = lng;

    emit(
      GatheringFormUpdated(
        selectedCategory: selectedCategory,
        selectedImageUrl: selectedImageUrl,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        selectedLat: selectedLat,
        selectedLng: selectedLng,
      ),
    );
  }

  // Sets event location after confirm the pin point
  void setLocation(double lat, double lng) {
    selectedLat = lat;
    selectedLng = lng;

    emit(
      GatheringFormUpdated(
        selectedCategory: selectedCategory,
        selectedImageUrl: selectedImageUrl,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        selectedLat: selectedLat,
        selectedLng: selectedLng,
      ),
    );
  }

  void setImage(String url) {
    selectedImageUrl = url;
    emit(
      GatheringFormUpdated(
        selectedCategory: selectedCategory,
        selectedImageUrl: selectedImageUrl,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        selectedLat: selectedLat,
        selectedLng: selectedLng,
      ),
    );
  }

  void setCategory(String category) {
    selectedCategory = category;

    emit(
      GatheringFormUpdated(
        selectedCategory: selectedCategory,
        selectedImageUrl: selectedImageUrl,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        selectedLat: selectedLat,
        selectedLng: selectedLng,
      ),
    );
  }

  void setDate(DateTime date) {
    selectedDate = date;
    emit(
      GatheringFormUpdated(
        selectedCategory: selectedCategory,
        selectedImageUrl: selectedImageUrl,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        selectedLat: selectedLat,
        selectedLng: selectedLng,
      ),
    );
  }

  void setTime(TimeOfDay time) {
    selectedTime = time;
    emit(
      GatheringFormUpdated(
        selectedCategory: selectedCategory,
        selectedImageUrl: selectedImageUrl,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        selectedLat: selectedLat,
        selectedLng: selectedLng,
      ),
    );
  }

  // fetch events
  Future<void> fetchEvents({String category = "All"}) async {
    selectedCategory = category;

    emit(GatheringLoading(selectedCategory: selectedCategory));

    final bookmarksResult = await userBookmarkUsecase();
    bookmarksResult.when(
      (ids) => userBookmarks = ids,
      (_) => userBookmarks = [],
    );

    final result = await getEventsUsecase();
    result.when(
      (events) {
        final filtered = category == "All"
            ? events
            : events.where((e) => e.category == category).toList();

        final updated = filtered.map((e) {
          return GatheringEntity(
            id: e.id,
            userId: e.userId,
            title: e.title,
            description: e.description,
            city: e.city,
            date: e.date,
            eventTime: e.eventTime,
            address: e.address,
            imageUrl: e.imageUrl,
            category: e.category,
            latitude: e.latitude,
            longitude: e.longitude,
            isBookmarked: userBookmarks.contains(e.id),
          );
        }).toList();

        emit(
          GatheringLoaded(events: updated, selectedCategory: selectedCategory),
        );
      },
      (error) => emit(
        GatheringError(message: error, selectedCategory: selectedCategory),
      ),
    );
  }

  // add event
  Future<void> addEvent(GatheringEntity entity) async {
    final result = await createGatheringUsecase(entity);
    result.when(
      (_) => fetchEvents(category: selectedCategory),
      (err) => emit(
        GatheringError(message: err, selectedCategory: selectedCategory),
      ),
    );
  }

  // search
  Future<void> search(String keyword) async {
    if (keyword.isEmpty) {
      fetchEvents(category: selectedCategory);
      return;
    }

    emit(GatheringLoading(selectedCategory: selectedCategory));

    final result = await searchEventsUseCase(keyword);
    result.when(
      (events) => emit(
        GatheringLoaded(events: events, selectedCategory: selectedCategory),
      ),
      (err) => emit(
        GatheringError(message: err, selectedCategory: selectedCategory),
      ),
    );
  }

  // map events
  Future<void> fetchMapEvents() async {
    emit(GatheringLoading(selectedCategory: selectedCategory));

    final result = await getMapEventsUseCase();

    result.when(
      (events) => emit(
        GatheringLoaded(events: events, selectedCategory: selectedCategory),
      ),
      (err) => emit(
        GatheringError(message: err, selectedCategory: selectedCategory),
      ),
    );
  }

  // method that's allows the user to join an event
  Future<void> joinEvent(String eventId) async {
    if (participants.contains(eventId)) {
      emit(
        GatheringMessage(
          message: "You already joined this event",
          selectedCategory: selectedCategory,
        ),
      );
      return;
    }

    final result = await joinEventUseCase(eventId);

    result.when(
      (_) {
        participants.add(eventId);

        loadParticipants(eventId);
        emit(
          GatheringMessage(
            message: "You have joined this event successfully",
            selectedCategory: selectedCategory,
          ),
        );
      },
      (err) {
        if (err.contains("duplicate") || err.contains("unique")) {
          emit(
            GatheringMessage(
              message: "You already joined this event",
              selectedCategory: selectedCategory,
            ),
          );
        } else {
          emit(
            GatheringError(message: err, selectedCategory: selectedCategory),
          );
        }
      },
    );
  }

  Future<void> loadParticipants(String eventId) async {
    final result = await getParticipantsUseCase(eventId);

    result.when(
      (success) {
        lastAvatars = success;
        emit(
          GatheringParticipantsLoaded(
            avatars: success,
            selectedCategory: selectedCategory,
          ),
        );
      },
      (err) => emit(
        GatheringError(message: err, selectedCategory: selectedCategory),
      ),
    );
  }

  // delete
  Future<void> deleteEvent(String id, String userId) async {
    emit(GatheringLoading(selectedCategory: selectedCategory));

    final result = await deleteGatheringUsecase(id, userId);

    result.when(
      (_) => fetchEvents(category: selectedCategory),
      (err) => emit(
        GatheringError(message: err, selectedCategory: selectedCategory),
      ),
    );
  }

  // toggle bookmark
Future<void> toggleBookmark(String eventId) async {
  if (userBookmarks.contains(eventId)) {
    await removeBookmark(eventId);
  } else {
    await addBookmark(eventId);
  }

  final result = await userBookmarkUsecase();
  result.when(
    (ids) => userBookmarks = ids,
    (_) => userBookmarks = [],
  );

  _updateBookmarkedEvents();
}



  void _updateBookmarkedEvents() {
    if (state is GatheringLoaded) {
      final s = state as GatheringLoaded;

      final updated = s.events.map((e) {
        return GatheringEntity(
          id: e.id,
          userId: e.userId,
          title: e.title,
          description: e.description,
          city: e.city,
          date: e.date,
          eventTime: e.eventTime,
          address: e.address,
          imageUrl: e.imageUrl,
          category: e.category,
          latitude: e.latitude,
          longitude: e.longitude,
          isBookmarked: userBookmarks.contains(e.id),
        );
      }).toList();

      emit(
        GatheringLoaded(events: updated, selectedCategory: selectedCategory),
      );
    }
  }
}
