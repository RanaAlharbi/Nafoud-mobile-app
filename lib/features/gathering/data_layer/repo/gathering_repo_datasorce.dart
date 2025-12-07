import 'package:final_project/features/gathering/data_layer/datasource/gathering_remote_datasource.dart';
import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@LazySingleton(as: GatheringDomainRepository)
class GatheringRepoDatasource implements GatheringDomainRepository {
  final BaseGatheringRemoteDataSource remoteDataSource;

  GatheringRepoDatasource(this.remoteDataSource);



  @override
  Future<Result<List<GatheringModel>, String>> getUsersEvents() async {
    return await remoteDataSource.getAllEvents();
  }

  @override
  Future<Result<void, String>> createUserEvent(GatheringModel event) {
    return remoteDataSource.createUserEvent(event);
  }

  @override
  Future<Result<void, String>> deleteUserEvent(String id, String userId) {
    return remoteDataSource.deleteUserEvent(id, userId);
  }
}
