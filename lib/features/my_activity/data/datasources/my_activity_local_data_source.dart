import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:final_project/features/my_activity/data/models/my_activity_model.dart';

abstract class BaseMyActivityLocalDataSource {
  Future<Either<String, MyActivityModel>> getCachedMyActivity();
  Future<Either<String, void>> saveMyActivity(MyActivityModel activity);
  Future<void> clearCache();
}

@LazySingleton(as: BaseMyActivityLocalDataSource)
class MyActivityLocalDataSource implements BaseMyActivityLocalDataSource {
  final GetStorage _storage;

  MyActivityLocalDataSource(this._storage);

  static const String _cacheKey = 'my_activity_cache';

  @override
  Future<Either<String, MyActivityModel>> getCachedMyActivity() async {
    try {
      final cachedData = _storage.read(_cacheKey);

      if (cachedData == null) {
        return const Left('No cached data available');
      }

      final Map<String, dynamic> data = Map<String, dynamic>.from(cachedData as Map);
      final activityModel = MyActivityModelMapper.fromMap(data);
      return Right(activityModel);
    } catch (error) {
      return Left('Failed to get cached data: ${error.toString()}');
    }
  }

  @override
  Future<Either<String, void>> saveMyActivity(MyActivityModel activity) async {
    try {
      await _storage.write(_cacheKey, activity.toMap());
      return const Right(null);
    } catch (error) {
      return Left('Failed to save data to cache: ${error.toString()}');
    }
  }

  @override
  Future<void> clearCache() async {
    await _storage.remove(_cacheKey);
  }
}
