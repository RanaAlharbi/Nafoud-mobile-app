import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';
import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@lazySingleton
class GetMapEventsUseCase {
  final GatheringDomainRepository repository;

  GetMapEventsUseCase(this.repository);

  Future<Result<List<GatheringEntity>, String>> call() {
    return repository.getEventsForMap();
  }
}
