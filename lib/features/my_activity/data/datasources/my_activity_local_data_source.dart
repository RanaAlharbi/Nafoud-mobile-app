import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/features/my_activity/data/models/my_activity_model.dart';

abstract class BaseMyActivityLocalDataSource {
  Future<Either<String, MyActivityModel>> getCachedMyActivity();
}

@LazySingleton(as: BaseMyActivityLocalDataSource)
class MyActivityLocalDataSource implements BaseMyActivityLocalDataSource {


  @override
  Future<Either<String, MyActivityModel>> getCachedMyActivity() async {
    throw Exception('No cached data available');
  }
}
