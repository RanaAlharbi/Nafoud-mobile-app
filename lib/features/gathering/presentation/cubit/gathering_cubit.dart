import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/create_gathering_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/delete_gathering_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/get_gatherings_usecase.dart';
import 'package:injectable/injectable.dart';

part 'gathering_state.dart';

@injectable
class GatheringCubit extends Cubit<GatheringState> {

  //Use cases 
  final GatheringUsecase gatheringUsecase; //to get all events
  final CreateGatheringUseCase createGatheringUseCase; //for creating event
  final DeleteGatheringUseCase deleteGatheringUseCase; //to delete only user created events 

  GatheringCubit(
    this.gatheringUsecase,
    this.createGatheringUseCase,
    this.deleteGatheringUseCase,
  ) : super(GatheringInitial());

Future<void> fetchEvents({String category = 'All'}) async {
  // إذا كنا في حالة Loaded احتفظ بالفئة الحالية وأظهر Loading
  if (state is GatheringLoaded) {
    final currentState = state as GatheringLoaded;
    emit(GatheringLoadingWithCategory(currentState.selectedCategory));
  } else {
    emit(GatheringLoadingWithCategory(category));
  }

  final result = await gatheringUsecase.call();
  result.when(
    (events) {
      final filtered = category == 'All'
          ? events
          : events.where((e) => e.category == category).toList();
      emit(GatheringLoaded(filtered, selectedCategory: category));
    },
    (error) => emit(GatheringError(error)),
  );
}

//to add events 
  Future<void> addEvent(GatheringModel event) async {
    emit(GatheringLoading());
    final result = await createGatheringUseCase.call(event);
    result.when(
      (_) => fetchEvents(),
      (error) => emit(GatheringError(error)),
    );
  }


//to delete event created by user 
  
  Future<void> deleteEvent(String id, String userId) async {
    emit(GatheringLoading());
    final result = await deleteGatheringUseCase.call(id, userId);
    result.when(
      (_) => fetchEvents(),
      (error) => emit(GatheringError(error)),
    );
  }
}
































// class GatheringCubit extends Cubit<GatheringState> {
//   final GatheringUsecase getEventsUseCase;
//   final CreateGatheringUseCase createEventUseCase;
//   final DeleteGatheringUseCase deleteEventUseCase;

//   GatheringCubit({
//     required this.getEventsUseCase,
//     required this.createEventUseCase,
//     required this.deleteEventUseCase,
//   }) : super(GatheringState([], false, 'All', null));

 
//   Future<void> fetchEvents({String? category}) async {
//     emit(GatheringState(state.events, true, category ?? 'All', null));
//     final Result<List<GatheringEntity>, String> result =
//         await getEventsUseCase.call();
//     result.when(
//       (entities) {
//         List<GatheringEntity> filtered = entities;
//         if (category != null && category != "All") {
//           filtered = entities.where((e) => e.category == category).toList();
//         }
//         emit(GatheringState(filtered, false, category ?? 'All', null));
//       },
//       (message) {
//         emit(GatheringState(state.events, false, state.selectedCategory, message));
//       },
//     );
//   }

  
//   Future<void> addEvent(GatheringModel event) async {
//     emit(GatheringState(state.events, true, state.selectedCategory, null));
//     final Result<void, String> result = await createEventUseCase.call(event);
//     result.when(
//       (_) => fetchEvents(category: state.selectedCategory),
//       (message) => emit(
//           GatheringState(state.events, false, state.selectedCategory, message)),
//     );
//   }

  
//   Future<void> removeEvent(String id, String userId) async {
//     emit(GatheringState(state.events, true, state.selectedCategory, null));
//     final Result<void, String> result = await deleteEventUseCase.call(id, userId);
//     result.when(
//       (_) => fetchEvents(category: state.selectedCategory),
//       (message) => emit(
//           GatheringState(state.events, false, state.selectedCategory, message)),
//     );
//   }
// }

// class GatheringState {
//   final List<GatheringEntity> events;
//   final bool isLoading;
//   final String selectedCategory;
//   final String? errorMessage;

//   GatheringState(
//     this.events,
//     this.isLoading,
//     this.selectedCategory,
//     this.errorMessage,
//   );
// }