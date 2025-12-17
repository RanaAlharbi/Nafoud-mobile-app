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
      final cachedResult = await localDataSource.getCachedMyActivity();

      if (cachedResult.isRight()) {
        return cachedResult;
      }

      final remoteResult = await remoteDataSource.getMyActivity();

      return await remoteResult.fold(
        (error) => Left(error),
        (activityModel) async {
          await localDataSource.saveMyActivity(activityModel);
          return Right(activityModel);
        },
      );
    } catch (error) {
      return Left('Failed to get my activity: ${error.toString()}');
    }
  }

  @override
  Future<Either<String, MyActivityModel>> refreshMyActivity() async {
    try {
      await localDataSource.clearCache();
      final remoteResult = await remoteDataSource.getMyActivity();

      return await remoteResult.fold(
        (error) => Left(error),
        (activityModel) async {
          await localDataSource.saveMyActivity(activityModel);
          return Right(activityModel);
        },
      );
    } catch (error) {
      return Left('Failed to refresh my activity: ${error.toString()}');
    }
  }
}
