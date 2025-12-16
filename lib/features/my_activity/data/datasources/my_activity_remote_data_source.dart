import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/features/my_activity/data/models/my_activity_model.dart';

abstract class BaseMyActivityRemoteDataSource {
  Future<Either<String, MyActivityModel>> getMyActivity();
}

@LazySingleton(as: BaseMyActivityRemoteDataSource)
class MyActivityRemoteDataSource implements BaseMyActivityRemoteDataSource {
  // final DioClient _dio;
  // final SupabaseClient _supabase;
  // final GetStorage _storage;
  // final FlutterSecureStorage _secureStorage;
  // final LocalKeysService _localKeysService;

  // MyActivityLocalDataSource(
  //   this._dio,
  //   this._supabase,
  //   this._storage,
  //   this._secureStorage,
  //   this._localKeysService
  // );

  @override
  Future<Either<String, MyActivityModel>> getMyActivity() async {
    try {
      return Right(MyActivityModel(id: "d"));
    } catch (error) {
      return Left('Failed to get activity: ${error.toString()}');
    }
  }
}
