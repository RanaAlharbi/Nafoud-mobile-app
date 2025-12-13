import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:final_project/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:final_project/features/weather/data/datasources/weather_get_storage_data_source.dart';
import 'package:final_project/features/weather/domain/entities/weather_entity.dart';
import 'package:final_project/features/weather/domain/repositories/weather_repository_domain.dart';

@LazySingleton(as: WeatherRepositoryDomain)
class WeatherRepositoryData implements WeatherRepositoryDomain {
  final BaseWeatherRemoteDataSource remoteDataSource;
  final BaseWeatherLocalDataSource localDataSource;
  final BaseWeatherGetStorageDataSource getStorageDataSource;

  WeatherRepositoryData(
    this.remoteDataSource,
    this.localDataSource,
    this.getStorageDataSource,
  );

  @override
  Future<Either<String, WeatherEntity>> getWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      // 1. First, try to get cached weather from GetStorage (instant display)
      final getStorageResult = getStorageDataSource.getCachedWeatherSync(
        lat: lat,
        lon: lon,
      );

      // If GetStorage has data, return it immediately for instant display
      if (getStorageResult.isRight()) {
        return getStorageResult;
      }

      // 2. If not in GetStorage, try to get cached weather from Supabase for today
      final cachedResult = await localDataSource.getCachedWeather(
        lat: lat,
        lon: lon,
      );

      return await cachedResult.fold(
        (cacheError) async {
          // 3. If no cache or cache is old, fetch from remote API
          final remoteResult = await remoteDataSource.getWeather(
            lat: lat,
            lon: lon,
          );

          return await remoteResult.fold(
            (remoteError) => Left(remoteError),
            (weatherModel) async {
              // 4. Save the fresh data to both Supabase and GetStorage
              await localDataSource.saveWeather(weatherModel);
              await getStorageDataSource.saveWeather(weatherModel);
              return Right(weatherModel);
            },
          );
        },
        // If cache exists in Supabase and is from today, save to GetStorage and use it
        (weatherModel) async {
          await getStorageDataSource.saveWeather(weatherModel);
          return Right(weatherModel);
        },
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
          // Save the fresh data to both Supabase and GetStorage
          await localDataSource.saveWeather(weatherModel);
          await getStorageDataSource.saveWeather(weatherModel);
          return Right(weatherModel);
        },
      );
    } catch (error) {
      return Left('Failed to get weather: ${error.toString()}');
    }
  }
}