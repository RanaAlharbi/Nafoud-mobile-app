import 'package:dartz/dartz.dart';
import 'package:final_project/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepositoryDomain {
  Future<Either<String, WeatherEntity>> getWeather({
    required double lat,
    required double lon,
  });

  Future<Either<String, WeatherEntity>> getWeatherByCity({
    required String cityName,
  });
}
