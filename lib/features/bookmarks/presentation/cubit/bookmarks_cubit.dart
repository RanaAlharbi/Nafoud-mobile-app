import 'package:final_project/features/bookmarks/domain/usecase/get_bookmarks_usecase.dart';
import 'package:final_project/features/bookmarks/domain/usecase/get_event_by_id.dart';
import 'package:final_project/features/bookmarks/presentation/cubit/bookmarks_state.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/add_bookmark_usecase.dart';
import 'package:final_project/features/gathering/domain_layer/usecase/remove_bookmark_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


@injectable
class BookmarkCubit extends Cubit<BookmarkState> {
  final GetBookmarksUseCase getBookmarks;
  final GetEventsByIdsUseCase getEventsByIds;  
  final AddBookmarkUseCase addBookmark;
  final RemoveBookmarkUseCase removeBookmark;

  BookmarkCubit(
    this.getBookmarks,
    this.getEventsByIds,
    this.addBookmark,
    this.removeBookmark,
  ) : super(BookmarkInitial());

  Future<void> loadBookmarks() async {
    emit(BookmarkLoading());

    final result = await getBookmarks();

    result.when((ids) async {
      if (ids.isEmpty) {
        emit(BookmarkLoaded([]));
        return;
      }

      final eventsResult = await getEventsByIds(ids);

      eventsResult.when(
        (events) => emit(BookmarkLoaded(events)),
        (err) => emit(BookmarkError(err)),
      );
    }, (err) {
      emit(BookmarkError(err));
    });
  }

  Future<void> toggle(String eventId) async {
    if (state is! BookmarkLoaded) return;

    final current = (state as BookmarkLoaded).events;

    final isBookmarked = current.any((e) => e.id == eventId);

    if (isBookmarked) {
      await removeBookmark(eventId);
    } else {
      await addBookmark(eventId);
    }

    await loadBookmarks();
  }
}
