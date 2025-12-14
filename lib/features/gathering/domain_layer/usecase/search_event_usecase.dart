import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@lazySingleton
class SearchEventsUseCase {
 final GatheringDomainRepository repository;

  SearchEventsUseCase(this.repository);

  Future<Result<List<GatheringEntity>, String>> call(String keyword) {
    return repository.searchEvents(keyword);
  }
}
