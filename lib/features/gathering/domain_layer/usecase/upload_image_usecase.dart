import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';


@injectable
class UploadImageUseCase {
  final GatheringDomainRepository repository;

  UploadImageUseCase(this.repository);

  Future<Result<String, String>> call(String path) {
    return repository.uploadImage(path);
  }
}
