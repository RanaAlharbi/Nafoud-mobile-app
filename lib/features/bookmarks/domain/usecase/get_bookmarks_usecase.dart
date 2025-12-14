
import 'package:final_project/features/bookmarks/domain/repo/bookmarks_repo.dart';
import 'package:multiple_result/multiple_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GetBookmarksUseCase {
  final BookmarkDomainRepository repo;

  GetBookmarksUseCase(this.repo);

  Future<Result<List<String>, String>> call() async {
    return repo.getBookmarks();
  }
}
