import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/weather/domain/entities/weather_entity.dart';
import 'package:final_project/features/weather/domain/repositories/weather_repository_domain.dart';

@lazySingleton
class WeatherUseCase {
  final WeatherRepositoryDomain _repositoryData;

  WeatherUseCase(this._repositoryData);

  Future<Either<String, WeatherEntity>> getWeather({
    required double lat,
    required double lon,
  }) async {
    return _repositoryData.getWeather(lat: lat, lon: lon);
  }

  Future<Either<String, WeatherEntity>> getWeatherByCity({
    required String cityName,
  }) async {
    return _repositoryData.getWeatherByCity(cityName: cityName);
  }
}
