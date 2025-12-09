import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/weather/data/models/weather_model.dart';


abstract class BaseWeatherRemoteDataSource {
  Future<Either<String, WeatherModel>> getWeather();
}


@LazySingleton(as: BaseWeatherRemoteDataSource)
class WeatherRemoteDataSource implements BaseWeatherRemoteDataSource {
  // final DioClient _dio;
  // final SupabaseClient _supabase;
  // final GetStorage _storage;
  // final FlutterSecureStorage _secureStorage;
  // final LocalKeysService _localKeysService;


   // WeatherRemoteDataSource(
  //   this._dio,
  //   this._supabase,
  //   this._storage,
  //   this._secureStorage,
  //   this._localKeysService
  // );



  @override
  Future<Either<String, WeatherModel>> getWeather() async {
    try {
      // TODO: Implement actual API call to fetch weather data
      // For now, returning mock data
      return Right(WeatherModel(id: "weather_001"));
    } catch (error) {
      return Left('Failed to fetch weather: ${error.toString()}');
    }
  }
}
