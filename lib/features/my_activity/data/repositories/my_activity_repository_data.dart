import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/features/my_activity/data/datasources/my_activity_local_data_source.dart';
import 'package:final_project/features/my_activity/data/datasources/my_activity_remote_data_source.dart';
import 'package:final_project/features/my_activity/data/models/my_activity_model.dart';
import 'package:final_project/features/my_activity/domain/repositories/my_activity_repository_domain.dart';

@LazySingleton(as: MyActivityRepositoryDomain)
class MyActivityRepositoryData implements MyActivityRepositoryDomain {
  final BaseMyActivityRemoteDataSource remoteDataSource;
  final BaseMyActivityLocalDataSource localDataSource;

  MyActivityRepositoryData(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<String, MyActivityModel>> getMyActivity() async {
    try {
      return await localDataSource.getCachedMyActivity();
    } catch (error) {
      return await remoteDataSource.getMyActivity();
    }
  }
}
