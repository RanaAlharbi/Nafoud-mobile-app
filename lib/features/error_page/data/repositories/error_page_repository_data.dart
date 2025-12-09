
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:final_project/features/error_page/data/datasources/error_page_local_data_source.dart';
import 'package:final_project/features/error_page/data/datasources/error_page_remote_data_source.dart';
import 'package:final_project/features/error_page/data/models/error_page_model.dart';
import 'package:final_project/features/error_page/domain/repositories/error_page_repository_domain.dart';

@LazySingleton(as: ErrorPageRepositoryDomain)
class ErrorPageRepositoryData implements ErrorPageRepositoryDomain{
  final BaseErrorPageRemoteDataSource remoteDataSource;
  final BaseErrorPageLocalDataSource localDataSource;

  ErrorPageRepositoryData(this.remoteDataSource, this.localDataSource);

  @override
    Future<Either<String, ErrorPageModel>> getErrorPage() async {
        try{
        return await localDataSource.getCachedErrorPage();
        }catch(error){
        return await remoteDataSource.getErrorPage();
        }
  }
}
