import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/features/my_activity/data/models/my_activity_model.dart';

abstract class BaseMyActivityLocalDataSource {
  Future<Either<String, MyActivityModel>> getCachedMyActivity();
}

@LazySingleton(as: BaseMyActivityLocalDataSource)
class MyActivityLocalDataSource implements BaseMyActivityLocalDataSource {
  // final GetStorage _storage;
  // final FlutterSecureStorage _secureStorage;
  // final LocalKeysService _localKeysService;

  // MyActivityLocalDataSource(
  //   this._storage,
  //   this._secureStorage,
  //   this._localKeysService
  // );

  @override
  Future<Either<String, MyActivityModel>> getCachedMyActivity() async {
    try {
      return Right(MyActivityModel(id: "d"));
    } catch (error) {
      return Left('Failed to get cached activity: ${error.toString()}');
    }
  }
}
