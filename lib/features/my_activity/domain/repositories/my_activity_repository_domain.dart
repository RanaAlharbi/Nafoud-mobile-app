import 'package:dartz/dartz.dart';
import 'package:final_project/features/my_activity/domain/entities/my_activity_entity.dart';

abstract class MyActivityRepositoryDomain {
  Future<Either<String, MyActivityEntity>> getMyActivity();
  Future<Either<String, MyActivityEntity>> refreshMyActivity();
}
