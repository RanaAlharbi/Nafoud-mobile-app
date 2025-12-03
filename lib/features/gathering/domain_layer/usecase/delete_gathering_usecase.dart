import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';

class DeleteGatheringUseCase {
 final GatheringDomainRepository repository;

  DeleteGatheringUseCase(this.repository);

  Future<void> call(String id, String userId) async {
    return await repository.deleteUserEvent(id,userId);
  }
}