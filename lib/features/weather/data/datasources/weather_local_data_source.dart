import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:final_project/features/weather/data/models/weather_model.dart';

abstract class BaseWeatherLocalDataSource {
  Future<Either<String, WeatherModel>> getCachedWeather({
    required double lat,
    required double lon,
  });

  Future<Either<String, void>> saveWeather(WeatherModel weather);
}

@LazySingleton(as: BaseWeatherLocalDataSource)
class WeatherLocalDataSource implements BaseWeatherLocalDataSource {
  final SupabaseClient _supabase;

  WeatherLocalDataSource(this._supabase);

  @override
  Future<Either<String, WeatherModel>> getCachedWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      // Get today's date at 00:00:00
      final today = DateTime.now();
      final todayStart = DateTime(today.year, today.month, today.day);

      // Query Supabase for weather data for this location from today
      final response = await _supabase
          .from('weather')
          .select()
          .eq('lat', lat)
          .eq('lon', lon)
          .gte('saved_at', todayStart.toIso8601String())
          .order('saved_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (response == null) {
        return const Left('No cached weather data for today');
      }

      final weatherModel = WeatherModel.fromSupabase(response);
      return Right(weatherModel);
    } catch (error) {
      return Left('Failed to get cached weather: ${error.toString()}');
    }
  }

  @override
  Future<Either<String, void>> saveWeather(WeatherModel weather) async {
    try {
      // Delete old weather data for this location
      await _supabase
          .from('weather')
          .delete()
          .eq('lat', weather.lat)
          .eq('lon', weather.lon);

      // Insert new weather data
      await _supabase.from('weather').insert(weather.toSupabase());

      return const Right(null);
    } catch (error) {
      return Left('Failed to save weather: ${error.toString()}');
    }
  }
}
