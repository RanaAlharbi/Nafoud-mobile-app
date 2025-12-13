import 'package:equatable/equatable.dart';
import 'package:final_project/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitialState extends WeatherState {
  const WeatherInitialState();
}

class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

class WeatherLoadedState extends WeatherState {
  final Map<String, WeatherEntity> weatherData;
  final String? errorMessage;
  final String searchQuery;

  const WeatherLoadedState({
    required this.weatherData,
    this.errorMessage,
    this.searchQuery = '',
  });

  // Get filtered cities based on search query
  Map<String, WeatherEntity> get filteredWeatherData {
    if (searchQuery.isEmpty) {
      return weatherData;
    }

    final query = searchQuery.toLowerCase();
    return Map.fromEntries(
      weatherData.entries.where((entry) =>
        entry.key.toLowerCase().contains(query)
      )
    );
  }

  @override
  List<Object?> get props => [weatherData, errorMessage, searchQuery];
}

class WeatherErrorState extends WeatherState {
  final String message;

  const WeatherErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

