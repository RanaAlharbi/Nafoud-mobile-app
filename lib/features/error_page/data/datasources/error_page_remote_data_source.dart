import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/features/error_page/data/models/error_page_model.dart';


abstract class BaseErrorPageRemoteDataSource {
  Future<Either<String, ErrorPageModel>> getErrorPage();
}


@LazySingleton(as: BaseErrorPageRemoteDataSource)
class ErrorPageRemoteDataSource implements BaseErrorPageRemoteDataSource {
  // final DioClient _dio;
  // final SupabaseClient _supabase;
  // final GetStorage _storage;
  // final FlutterSecureStorage _secureStorage;
  // final LocalKeysService _localKeysService;


   // ErrorPageLocalDataSource(
  //   this._dio,
  //   this._supabase,
  //   this._storage,
  //   this._secureStorage,
  //   this._localKeysService
  // );



    @override
  Future<Either<String, ErrorPageModel>> getErrorPage() async {
    try {
      return Right(ErrorPageModel(id: "d"));
    } catch (error) {
      return Left(error.toString());
    }
  }
}
