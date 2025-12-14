import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:final_project/features/bookmarks/domain/repo/bookmarks_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';


@lazySingleton
class GetEventsByIdsUseCase {
  final BookmarkDomainRepository repo;

  GetEventsByIdsUseCase(this.repo);

  Future<Result<List<GatheringEntity>, String>> call(List<String> ids) async {
    return repo.getEventsByIds(ids);
  }
}
