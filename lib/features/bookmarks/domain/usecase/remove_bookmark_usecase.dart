import 'package:final_project/features/bookmarks/domain/repo/bookmarks_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';


@lazySingleton
class RemoveBookmarkUseCase {
  final BookmarkDomainRepository repo;

  RemoveBookmarkUseCase(this.repo);

  Future<Result<bool, String>> call(String eventId) async {
    return repo.remove(eventId);
  }
}
