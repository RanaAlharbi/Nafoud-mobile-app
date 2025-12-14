import 'package:dart_mappable/dart_mappable.dart';
import 'package:final_project/features/weather/domain/entities/weather_entity.dart';
part 'weather_model.mapper.dart';

@MappableClass()
class WeatherModel extends WeatherEntity with WeatherModelMappable {
  const WeatherModel({
    required super.lon,
    required super.lat,
    required super.weatherId,
    required super.weatherMain,
    required super.weatherDescription,
    required super.weatherIcon,
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.savedAt,
  });

  // Factory to create from OpenWeatherMap API response
  factory WeatherModel.fromApi(Map<String, dynamic> json) {
    return WeatherModel(
      lon: _toDouble(json['coord']?['lon'], 0.0),
      lat: _toDouble(json['coord']?['lat'], 0.0),
      weatherId: json['weather']?[0]?['id'] ?? 0,
      weatherMain: json['weather']?[0]?['main'] ?? 'Unknown',
      weatherDescription: json['weather']?[0]?['description'] ?? '',
      weatherIcon: json['weather']?[0]?['icon'] ?? '01d',
      temp: _toDouble(json['main']?['temp'], 0.0),
      feelsLike: _toDouble(json['main']?['feels_like'], 0.0),
      tempMin: _toDouble(json['main']?['temp_min'], 0.0),
      tempMax: _toDouble(json['main']?['temp_max'], 0.0),
      savedAt: DateTime.now(),
    );
  }

  static double _toDouble(dynamic value, double defaultValue) {
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value);
      return parsed ?? defaultValue;
    }
    return defaultValue;
  }

  // Convert to Supabase format
  Map<String, dynamic> toSupabase() {
    return {
      'lon': lon,
      'lat': lat,
      'weather_id': weatherId,
      'weather_main': weatherMain,
      'weather_description': weatherDescription,
      'weather_icon': weatherIcon,
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'saved_at': savedAt.toIso8601String(),
    };
  }

  // Factory to create from Supabase response
  factory WeatherModel.fromSupabase(Map<String, dynamic> json) {
    return WeatherModel(
      lon: _toDouble(json['lon'], 0.0),
      lat: _toDouble(json['lat'], 0.0),
      weatherId: json['weather_id'] ?? 0,
      weatherMain: json['weather_main'] ?? 'Unknown',
      weatherDescription: json['weather_description'] ?? '',
      weatherIcon: json['weather_icon'] ?? '01d',
      temp: _toDouble(json['temp'], 0.0),
      feelsLike: _toDouble(json['feels_like'], 0.0),
      tempMin: _toDouble(json['temp_min'], 0.0),
      tempMax: _toDouble(json['temp_max'], 0.0),
      savedAt: json['saved_at'] != null
          ? DateTime.parse(json['saved_at'])
          : DateTime.now(),
    );
  }

  // Convert to JSON Map for GetStorage
  Map<String, dynamic> toJsonMap() {
    return {
      'lon': lon,
      'lat': lat,
      'weatherId': weatherId,
      'weatherMain': weatherMain,
      'weatherDescription': weatherDescription,
      'weatherIcon': weatherIcon,
      'temp': temp,
      'feelsLike': feelsLike,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'savedAt': savedAt.toIso8601String(),
    };
  }

  // Factory to create from JSON Map (GetStorage)
  factory WeatherModel.fromJsonMap(Map<String, dynamic> json) {
    return WeatherModel(
      lon: _toDouble(json['lon'], 0.0),
      lat: _toDouble(json['lat'], 0.0),
      weatherId: json['weatherId'] ?? 0,
      weatherMain: json['weatherMain'] ?? 'Unknown',
      weatherDescription: json['weatherDescription'] ?? '',
      weatherIcon: json['weatherIcon'] ?? '01d',
      temp: _toDouble(json['temp'], 0.0),
      feelsLike: _toDouble(json['feelsLike'], 0.0),
      tempMin: _toDouble(json['tempMin'], 0.0),
      tempMax: _toDouble(json['tempMax'], 0.0),
      savedAt: json['savedAt'] != null
          ? DateTime.parse(json['savedAt'])
          : DateTime.now(),
    );
  }
}

