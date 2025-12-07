import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/features/error_page/data/models/error_page_model.dart';




abstract class BaseErrorPageLocalDataSource {

   Future<Either<String, ErrorPageModel>> getCachedErrorPage();

}


@LazySingleton(as: BaseErrorPageLocalDataSource)
class ErrorPageLocalDataSource implements BaseErrorPageLocalDataSource {
  // final GetStorage _storage;
  // final FlutterSecureStorage _secureStorage;
  // final LocalKeysService _localKeysService;



   // ErrorPageLocalDataSource(
  //   this._storage,
  //   this._secureStorage,
  //   this._localKeysService
  // );


  @override
  Future<Either<String, ErrorPageModel>> getCachedErrorPage() async {
  try {
      return Right(ErrorPageModel(id: "d"));
    } catch (error) {
      return Left(error.toString());
    }
  }
}
