import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/my_activity/domain/entities/my_activity_entity.dart';
import 'package:final_project/features/my_activity/domain/repositories/my_activity_repository_domain.dart';

@lazySingleton
class MyActivityUseCase {
  final MyActivityRepositoryDomain _repositoryData;

  MyActivityUseCase(this._repositoryData);

  Future<Either<String, MyActivityEntity>> getMyActivity() async {
    return _repositoryData.getMyActivity();
  }

  Future<Either<String, MyActivityEntity>> refreshMyActivity() async {
    return _repositoryData.refreshMyActivity();
  }
}
