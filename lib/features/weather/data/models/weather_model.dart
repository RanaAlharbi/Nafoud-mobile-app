import 'package:dart_mappable/dart_mappable.dart';
import 'package:final_project/features/weather/domain/entities/weather_entity.dart';
part 'weather_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class WeatherModel extends WeatherEntity with WeatherModelMappable {
  WeatherModel({required super.id});
}

