import 'package:dart_mappable/dart_mappable.dart';
import 'package:final_project/features/error_page/domain/entities/error_page_entity.dart';
part 'error_page_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class ErrorPageModel extends ErrorPageEntity with ErrorPageModelMappable {
  ErrorPageModel({required super.id});
}

