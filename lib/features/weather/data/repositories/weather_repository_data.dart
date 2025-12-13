import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:final_project/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:final_project/features/weather/domain/entities/weather_entity.dart';
import 'package:final_project/features/weather/domain/repositories/weather_repository_domain.dart';

@LazySingleton(as: WeatherRepositoryDomain)
class WeatherRepositoryData implements WeatherRepositoryDomain {
  final BaseWeatherRemoteDataSource remoteDataSource;
  final BaseWeatherLocalDataSource localDataSource;

  WeatherRepositoryData(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<String, WeatherEntity>> getWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      // 1. Try to get cached weather from Supabase for today
      final cachedResult = await localDataSource.getCachedWeather(
        lat: lat,
        lon: lon,
      );

      return await cachedResult.fold(
        (cacheError) async {
          // 2. If no cache or cache is old, fetch from remote API
          final remoteResult = await remoteDataSource.getWeather(
            lat: lat,
            lon: lon,
          );

          return await remoteResult.fold(
            (remoteError) => Left(remoteError),
            (weatherModel) async {
              // 3. Save the fresh data to Supabase for future use
              await localDataSource.saveWeather(weatherModel);
              return Right(weatherModel);
            },
          );
        },
        // If cache exists and is from today, use it
        (weatherModel) => Right(weatherModel),
      );
    } catch (error) {
      return Left('Failed to get weather: ${error.toString()}');
    }
  }

  @override
  Future<Either<String, WeatherEntity>> getWeatherByCity({
    required String cityName,
  }) async {
    try {
      // Fetch weather by city name from remote API
      final remoteResult = await remoteDataSource.getWeatherByCity(
        cityName: cityName,
      );

      return await remoteResult.fold(
        (remoteError) => Left(remoteError),
        (weatherModel) async {
          // Save the fresh data to Supabase for future use
          await localDataSource.saveWeather(weatherModel);
          return Right(weatherModel);
        },
      );
    } catch (error) {
      return Left('Failed to get weather: ${error.toString()}');
    }
  }
}
