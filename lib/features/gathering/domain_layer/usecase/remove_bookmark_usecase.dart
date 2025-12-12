import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';


@lazySingleton
class RemoveBookmarkUseCase {
  final GatheringDomainRepository repo;

  RemoveBookmarkUseCase(this.repo);

  Future<Result<void, String>> call(String eventId) {
    return repo.removeBookmark(eventId);
  }
}
