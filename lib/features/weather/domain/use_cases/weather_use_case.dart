import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/weather/domain/entities/weather_entity.dart';
import 'package:final_project/features/weather/domain/repositories/weather_repository_domain.dart';


@lazySingleton
class WeatherUseCase {
  final WeatherRepositoryDomain _repositoryData;

  WeatherUseCase(this._repositoryData);

   Future<Either<String, WeatherEntity>> getWeather() async {
    return _repositoryData.getWeather();
  }
}
