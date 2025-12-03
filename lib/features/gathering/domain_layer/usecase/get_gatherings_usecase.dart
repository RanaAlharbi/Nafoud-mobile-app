import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';
import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';

class GatheringUsecase {
  final GatheringDomainRepository repository;

  GatheringUsecase(this.repository);

  Future<List<GatheringEntity>> call() async {
    return await repository.getUsersEvents();
  }
}