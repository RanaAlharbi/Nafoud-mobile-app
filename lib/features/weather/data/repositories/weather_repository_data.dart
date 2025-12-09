import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:final_project/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:final_project/features/weather/domain/entities/weather_entity.dart';
import 'package:final_project/features/weather/domain/repositories/weather_repository_domain.dart';

@LazySingleton(as: WeatherRepositoryDomain)
class WeatherRepositoryData implements WeatherRepositoryDomain{
  final BaseWeatherRemoteDataSource remoteDataSource;
  final BaseWeatherLocalDataSource localDataSource;

  WeatherRepositoryData(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<String, WeatherEntity>> getWeather() async {
    try {
      // Try to get cached weather first
      final cachedResult = await localDataSource.getCachedWeather();
      return cachedResult.fold(
        (error) async {
          // If cache fails, fetch from remote
          return await remoteDataSource.getWeather();
        },
        (weatherModel) => Right(weatherModel),
      );
    } catch (error) {
      return Left('Failed to get weather: ${error.toString()}');
    }
  }
}
