import 'package:bloc/bloc.dart';
import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';
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
  String? selectedCategory;
  String? selectedImageUrl;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  double? selectedLat;
  double? selectedLng;
  String title = "";
  String description = "";
  String city = "";
  String address = "";

  final categories = const [
    "All",
    "Cultural",
    "Sports",
    "Arts",
    "Entertainment",
  ];
  List<String> userBookmarks = [];

  List<String> participants = [];

  //use cases
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
  ) : super(GatheringInitial());

  Future<void> uploadImage(String filePath) async {
    final result = await uploadImageUseCase(filePath);

    result.when(
      (url) {
        selectedImageUrl = url;
        emit(GatheringFormUpdated());
      },
      (err) {
        emit(GatheringError(err));
      },
    );
  }


  void setTitle(String value) {
  title = value;
  emit(GatheringFormUpdated());
}

void setDescription(String value) {
  description = value;
  emit(GatheringFormUpdated());
}

void setCity(String value) {
  city = value;
  emit(GatheringFormUpdated());
}

void setAddress(String value) {
  address = value;
  emit(GatheringFormUpdated());
}


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
    emit(GatheringFormUpdated());
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
    emit(GatheringFormUpdated());
  }

  void setTime(TimeOfDay time) {
    selectedTime = time;
    emit(GatheringFormUpdated());
  }

  Future<void> fetchEvents({String category = "All"}) async {
    emit(GatheringLoading());

    
    final bookmarksResult = await userBookmarkUsecase();

    bookmarksResult.when(
      (ids) => userBookmarks = ids,
      (err) => userBookmarks = [],
    );

   
    final result = await getEventsUsecase();

    result.when((events) {
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

      emit(GatheringLoaded(updated, selectedCategory: category));
    }, (error) => emit(GatheringError(error)));
  }

  Future<void> search(String keyword) async {
    if (keyword.isEmpty) {
      fetchEvents();
      return;
    }

    emit(GatheringLoading());

    final result = await searchEventsUseCase(keyword);

    result.when(
      (events) => emit(GatheringLoaded(events, selectedCategory: "All")),
      (error) => emit(GatheringError(error)),
    );
  }

  Future<void> fetchMapEvents() async {
    emit(GatheringLoading());

    final result = await getMapEventsUseCase();

    result.when(
      (events) => emit(GatheringLoaded(events, selectedCategory: "All")),
      (error) => emit(GatheringError(error)),
    );
  }

  Future<void> addEvent(GatheringEntity entity) async {
    final result = await createGatheringUsecase(entity);

    result.when(
      (_) {
        fetchEvents();
      },
      (error) {
        emit(GatheringError(error));
      },
    );
  }

  Future<void> joinEvent(String eventId) async {
    final result = await joinEventUseCase(eventId);

    result.when(
      (_) {
        loadParticipants(eventId);
        emit(GatheringMessage("You joined this event successfully"));
      },
      (err) {
        if (err.contains("duplicate key") || err.contains("unique")) {
          emit(GatheringMessage("You already joined this event"));
        } else {
          emit(GatheringError(err));
        }
      },
    );
  }

  Future<void> loadParticipants(String eventId) async {
    final result = await getParticipantsUseCase(eventId);

    result.when(
      (imgs) => emit(GatheringParticipantsLoaded(imgs)),
      (err) => emit(GatheringError(err)),
    );
  }

  Future<void> deleteEvent(String id, String userId) async {
    emit(GatheringLoading());

    final result = await deleteGatheringUsecase(id, userId);

    result.when((_) => fetchEvents(), (err) => emit(GatheringError(err)));
  }

  Future<void> toggleBookmark(String eventId) async {
    final isSaved = userBookmarks.contains(eventId);

    if (isSaved) {
      await removeBookmark(eventId);
      userBookmarks.remove(eventId);
    } else {
      await addBookmark(eventId);
      userBookmarks.add(eventId);
    }

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

      emit(GatheringLoaded(updated, selectedCategory: s.selectedCategory));
    }
  }
}
