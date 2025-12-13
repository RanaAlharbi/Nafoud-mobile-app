import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@lazySingleton
class GetUserBookmarkUsecase {
  final GatheringDomainRepository repo;

  GetUserBookmarkUsecase(this.repo);

  Future<Result<List<String>, String>>  call() {
    return repo.getUserBookmarks();
  }
}
