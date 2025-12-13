import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:final_project/features/weather/data/models/weather_model.dart';

abstract class BaseWeatherGetStorageDataSource {
  Either<String, WeatherModel> getCachedWeatherSync({
    required double lat,
    required double lon,
  });

  Future<Either<String, void>> saveWeather(WeatherModel weather);

  Future<Either<String, void>> clearCache();
}

@LazySingleton(as: BaseWeatherGetStorageDataSource)
class WeatherGetStorageDataSource implements BaseWeatherGetStorageDataSource {
  final GetStorage _storage;

  WeatherGetStorageDataSource(this._storage);

  // Generate unique key for weather data based on location
  String _generateKey(double lat, double lon) {
    return 'weather_${lat.toStringAsFixed(4)}_${lon.toStringAsFixed(4)}';
  }

  @override
  Either<String, WeatherModel> getCachedWeatherSync({
    required double lat,
    required double lon,
  }) {
    try {
      final key = _generateKey(lat, lon);
      final cachedData = _storage.read<Map<String, dynamic>>(key);

      if (cachedData == null) {
        return const Left('No cached weather data in local storage');
      }

      // Parse the saved weather data
      final weatherModel = WeatherModel.fromJsonMap(cachedData);
      return Right(weatherModel);
    } catch (error) {
      return Left('Failed to get cached weather from local storage: ${error.toString()}');
    }
  }

  @override
  Future<Either<String, void>> saveWeather(WeatherModel weather) async {
    try {
      final key = _generateKey(weather.lat, weather.lon);

      // Save weather data as JSON
      await _storage.write(key, weather.toJsonMap());

      return const Right(null);
    } catch (error) {
      return Left('Failed to save weather to local storage: ${error.toString()}');
    }
  }

  @override
  Future<Either<String, void>> clearCache() async {
    try {
      await _storage.erase();
      return const Right(null);
    } catch (error) {
      return Left('Failed to clear weather cache: ${error.toString()}');
    }
  }
}
