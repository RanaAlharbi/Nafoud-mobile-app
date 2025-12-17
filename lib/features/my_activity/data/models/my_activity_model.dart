import 'package:dart_mappable/dart_mappable.dart';
import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
import 'package:final_project/features/my_activity/domain/entities/my_activity_entity.dart';
part 'my_activity_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class MyActivityModel extends MyActivityEntity with MyActivityModelMappable {
  @override
  final List<GatheringModel> events;

  MyActivityModel({required this.events}) : super(events: events);
}

