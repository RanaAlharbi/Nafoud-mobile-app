import 'package:equatable/equatable.dart';
import 'package:final_project/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherEntity weather;

  const WeatherLoadedState({required this.weather});

  @override
  List<Object?> get props => [weather];
}

class WeatherErrorState extends WeatherState {
  final String message;
  const WeatherErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

