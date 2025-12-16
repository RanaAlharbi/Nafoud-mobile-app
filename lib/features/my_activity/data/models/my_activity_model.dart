import 'package:dart_mappable/dart_mappable.dart';
import 'package:final_project/features/my_activity/domain/entities/my_activity_entity.dart';
part 'my_activity_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class MyActivityModel extends MyActivityEntity with MyActivityModelMappable {
  MyActivityModel({required super.id});
}

