import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@lazySingleton
class GetParticipantsUseCase  {
 final GatheringDomainRepository repository;

  GetParticipantsUseCase  (this.repository);

  Future<Result<List<String>, String>> call(String eventId) {
    return repository.getParticipants(eventId);
  }
}