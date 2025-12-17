import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:final_project/features/my_activity/domain/entities/my_activity_entity.dart';
import 'package:final_project/features/my_activity/domain/use_cases/my_activity_use_case.dart';
import 'package:final_project/features/my_activity/presentation/cubit/my_activity_state.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/add_bookmark_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/remove_bookmark_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/get_user_bookmark.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/get_participants_usecase.dart';

@injectable
class MyActivityCubit extends Cubit<MyActivityState> {
  final MyActivityUseCase _myActivityUseCase;
  final AddBookmarkUseCase _addBookmark;
  final RemoveBookmarkUseCase _removeBookmark;
  final GetUserBookmarkUsecase _userBookmarkUsecase;
  final GetParticipantsUseCase _getParticipantsUseCase;

  List<String> userBookmarks = [];
  List<String> participants = [];

  MyActivityCubit(
    this._myActivityUseCase,
    this._addBookmark,
    this._removeBookmark,
    this._userBookmarkUsecase,
    this._getParticipantsUseCase,
  ) : super(MyActivityInitialState());

  Future<void> getMyActivityMethod() async {
    final result = await _myActivityUseCase.getMyActivity();
    result.fold(
      (error) {
        emit(MyActivityErrorState(error));
      },
      (success) {
        emit(MyActivitySuccessState(success));
      },
    );
  }

  Future<void> refreshMyActivity() async {
    final result = await _myActivityUseCase.refreshMyActivity();
    result.fold(
      (error) {
        emit(MyActivityErrorState(error));
      },
      (success) {
        emit(MyActivitySuccessState(success));
      },
    );
  }

  Future<void> toggleBookmark(String eventId) async {
    if (userBookmarks.contains(eventId)) {
      await _removeBookmark(eventId);
    } else {
      await _addBookmark(eventId);
    }

    final result = await _userBookmarkUsecase();
    result.when(
      (ids) => userBookmarks = ids,
      (_) => userBookmarks = [],
    );

    _updateBookmarkedEvents();
  }

  void _updateBookmarkedEvents() {
    if (state is MyActivitySuccessState) {
      final currentState = state as MyActivitySuccessState;

      final updatedEvents = currentState.activity.events.map((e) {
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

      emit(MyActivitySuccessState(
        MyActivityEntity(events: updatedEvents),
      ));
    }
  }

  Future<void> loadParticipants(String eventId) async {
    final result = await _getParticipantsUseCase(eventId);

    result.when(
      (success) {
        participants = success;
        emit(MyActivityParticipantsLoadedState(participants));
      },
      (error) {
        participants = [];
      },
    );
  }
}
