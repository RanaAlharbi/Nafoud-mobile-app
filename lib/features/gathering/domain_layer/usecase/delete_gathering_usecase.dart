import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@lazySingleton
class DeleteGatheringUseCase {
 final GatheringDomainRepository repository;

  DeleteGatheringUseCase(this.repository);

  Future<Result<void, String>> call(String id, String userId) async {
    return await repository.deleteUserEvent(id, userId);
  }
}