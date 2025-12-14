import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/weather/data/models/weather_model.dart';

abstract class BaseWeatherRemoteDataSource {
  Future<Either<String, WeatherModel>> getWeather({
    required double lat,
    required double lon,
  });

  Future<Either<String, WeatherModel>> getWeatherByCity({
    required String cityName,
  });
}

@LazySingleton(as: BaseWeatherRemoteDataSource)
class WeatherRemoteDataSource implements BaseWeatherRemoteDataSource {
  final Dio _dio;

  WeatherRemoteDataSource(this._dio);

  @override
  Future<Either<String, WeatherModel>> getWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      final apiKey = dotenv.env['OpenWeatherAPIKey'];

      if (apiKey == null || apiKey.isEmpty) {
        return const Left('OpenWeather API key is missing');
      }

      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': apiKey,
          'units': 'metric',
        },
      );

      if (response.statusCode == 200) {
        final weatherModel = WeatherModel.fromApi(response.data);
        return Right(weatherModel);
      } else {
        return Left('Failed to fetch weather: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      return Left('Network error: ${e.message}');
    } catch (error) {
      return Left('Failed to fetch weather: ${error.toString()}');
    }
  }

  @override
  Future<Either<String, WeatherModel>> getWeatherByCity({
    required String cityName,
  }) async {
    try {
      final apiKey = dotenv.env['OpenWeatherAPIKey'];

      if (apiKey == null || apiKey.isEmpty) {
        return const Left('OpenWeather API key is missing');
      }

      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'q': cityName,
          'appid': apiKey,
          'units': 'metric',
        },
      );

      if (response.statusCode == 200) {
        final weatherModel = WeatherModel.fromApi(response.data);
        return Right(weatherModel);
      } else {
        return Left('Failed to fetch weather: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const Left('City not found. Please check the spelling and try again.');
      }
      return Left('Network error: ${e.message}');
    } catch (error) {
      return Left('Failed to fetch weather: ${error.toString()}');
    }
  }
}
