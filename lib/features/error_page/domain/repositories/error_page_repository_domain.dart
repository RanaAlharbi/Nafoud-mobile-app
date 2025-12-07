import 'package:dartz/dartz.dart';
import 'package:final_project/features/error_page/domain/entities/error_page_entity.dart';

abstract class ErrorPageRepositoryDomain {
    Future<Either<String, ErrorPageEntity>> getErrorPage();
}
