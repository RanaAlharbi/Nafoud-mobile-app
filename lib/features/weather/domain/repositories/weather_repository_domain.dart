import 'package:dartz/dartz.dart';
import 'package:final_project/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepositoryDomain {
    Future<Either<String, WeatherEntity>> getWeather();
}
