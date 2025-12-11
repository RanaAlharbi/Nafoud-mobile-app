import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final double lon;
  final double lat;
  final int weatherId;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final DateTime savedAt;

  const WeatherEntity({
    required this.lon,
    required this.lat,
    required this.weatherId,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.savedAt,
  });

  @override
  List<Object?> get props => [
        lon,
        lat,
        weatherId,
        weatherMain,
        weatherDescription,
        weatherIcon,
        temp,
        feelsLike,
        tempMin,
        tempMax,
        savedAt,
      ];
}
