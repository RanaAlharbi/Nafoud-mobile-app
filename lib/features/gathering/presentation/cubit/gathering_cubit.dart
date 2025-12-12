import 'package:bloc/bloc.dart';
import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/add_bookmark_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/remove_bookmark_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/create_gathering_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/delete_gathering_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/get_gatherings_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/get_map_events_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/search_event_usecase.dart';
import 'gathering_state.dart';

@injectable

class GatheringCubit extends Cubit<GatheringState> {


  
   final categories = const [
    "All",
    "Cultural",
    "Sports",
    "Arts",
    "Entertainment",
  ];

  List<String> userBookmarks = [];

  //use cases
  final GatheringUsecase getEventsUsecase;
  final CreateGatheringUseCase createGatheringUsecase;
  final DeleteGatheringUseCase deleteGatheringUsecase;
  final SearchEventsUseCase searchEventsUseCase;
  final GetMapEventsUseCase getMapEventsUseCase;
  final  AddBookmarkUseCase addBookmark;
  final RemoveBookmarkUseCase removeBookmark;
  GatheringCubit(
    this.getEventsUsecase,
    this.createGatheringUsecase,
    this.deleteGatheringUsecase,
    this.searchEventsUseCase,
    this.getMapEventsUseCase, 
    this.addBookmark, 
    this.removeBookmark,
  ) : super(GatheringInitial());


Future<void> fetchEvents({String category = "All"}) async {
  if (state is GatheringLoaded) {
    emit(GatheringLoadingWithCategory(category));
  } else {
    emit(GatheringLoading());
  }

  final result = await getEventsUsecase();

  result.when(
    (events) {
      final filtered = category == "All"
          ? events
          : events.where((e) => e.category == category).toList();


      final updated = filtered.map((e) =>
          GatheringEntity(
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
          ),
      ).toList();

      emit(GatheringLoaded(updated, selectedCategory: category));
    },
    (error) => emit(GatheringError(error)),
  );
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
  emit(GatheringLoading());

  final result = await createGatheringUsecase(entity);

  result.when(
    (_) => fetchEvents(),
    (error) => emit(GatheringError(error)),
  );
}



  Future<void> deleteEvent(String id, String userId) async {
    emit(GatheringLoading());

    final result = await deleteGatheringUsecase(id, userId);

    result.when(
      (_) => fetchEvents(),
      (err) => emit(GatheringError(err)),
    );
  }


Future<void> toggleBookmark(String eventId) async {
  final isSaved = userBookmarks.contains(eventId);

  if (isSaved) {
    userBookmarks.remove(eventId);
  } else {
    userBookmarks.add(eventId);
  }

  _updateBookmarkedEvents();

  if (isSaved) {
    await removeBookmark(eventId);
  } else {
    await addBookmark(eventId);
  }
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








