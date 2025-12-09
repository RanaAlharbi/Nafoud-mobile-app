import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/weather/data/models/weather_model.dart';




abstract class BaseWeatherLocalDataSource {

   Future<Either<String, WeatherModel>> getCachedWeather();

}


@LazySingleton(as: BaseWeatherLocalDataSource)
class WeatherLocalDataSource implements BaseWeatherLocalDataSource {
  // final GetStorage _storage;
  // final FlutterSecureStorage _secureStorage;
  // final LocalKeysService _localKeysService;



   // WeatherLocalDataSource(
  //   this._storage,
  //   this._secureStorage,
  //   this._localKeysService
  // );


  @override
  Future<Either<String, WeatherModel>> getCachedWeather() async {
    try {
      // TODO: Implement actual cache retrieval logic
      // For now, returning an error to trigger remote fetch
      return Left('No cached weather data available');
    } catch (error) {
      return Left('Failed to get cached weather: ${error.toString()}');
    }
  }
}
