import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:final_project/features/bookmarks/data/datasource/bookmarks_datasorce.dart';
import 'package:final_project/features/bookmarks/domain/repo/bookmarks_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';


@LazySingleton(as: BookmarkDomainRepository)
class BookmarkRepositoryImpl implements BookmarkDomainRepository {
  final BaseBookmarkDataSource remote;

  BookmarkRepositoryImpl(this.remote);
 @override
  Future<Result<List<GatheringEntity>, String>> getEventsByIds(List<String> ids) async {
    try {
      final result = await remote.getEventsByIds(ids);
      return Result.success(result);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
  

  @override
  Future<Result<List<String>, String>> getBookmarks() async {
    try {
      final result = await remote.getUserBookmarks();
      return Result.success(result);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<bool, String>> add(String eventId) async {
    try {
      await remote.addBookmark(eventId);
      return const Result.success(true);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<bool, String>> remove(String eventId) async {
    try {
      await remote.removeBookmark(eventId);
      return const Result.success(true);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
