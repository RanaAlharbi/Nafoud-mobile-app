import 'package:final_project/features/gathering/data_layer/datasource/gathering_remote_datasource.dart';
import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';
import 'package:final_project/features/gathering/domain_layer/repo/gathering_domain_repository.dart';

class GatheringRepoDatasorce implements GatheringDomainRepository {
 final BaseGatheringRemoteDataSource remoteDataSource;

  GatheringRepoDatasorce(this.remoteDataSource);


  @override
  Future<void> deleteUserEvent(String id, String userId) async {
    await remoteDataSource.deleteUserEvent(id, userId);
  }

  @override
  Future<List<GatheringModel>> getUsersEvents() async {
      return await remoteDataSource.getAllEvents();

  }
  
  @override
  Future<void> createUserEvent(GatheringEntity gathering) {
    // TODO: implement createUserEvent
    throw UnimplementedError();
  }

}