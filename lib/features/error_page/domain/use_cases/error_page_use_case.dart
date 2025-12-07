import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/error_page/domain/entities/error_page_entity.dart';
import 'package:final_project/features/error_page/domain/repositories/error_page_repository_domain.dart';


@lazySingleton
class ErrorPageUseCase {
  final ErrorPageRepositoryDomain _repositoryData;

  ErrorPageUseCase(this._repositoryData);

   Future<Either<String, ErrorPageEntity>> getErrorPage() async {
    return _repositoryData.getErrorPage();
  }
}
