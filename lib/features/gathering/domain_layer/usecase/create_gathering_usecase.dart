import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';
import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';

class CreateGatheringUseCase {
 final GatheringDomainRepository repository;

  CreateGatheringUseCase(this.repository);

  Future<void> createUserEvent (GatheringEntity gathering) async {
    return await repository.createUserEvent(gathering);
  }
}