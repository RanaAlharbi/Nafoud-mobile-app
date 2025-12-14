import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@lazySingleton
class CreateGatheringUseCase {
 final GatheringDomainRepository repository;

  CreateGatheringUseCase(this.repository);

 Future<Result<void, String>> call(GatheringModel event) async {
    return await repository.createUserEvent(event);
  }
}