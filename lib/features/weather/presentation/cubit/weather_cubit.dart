import 'package:final_project/features/weather/domain/entities/weather_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/weather/domain/use_cases/weather_use_case.dart';
import 'package:final_project/features/weather/presentation/cubit/weather_state.dart';

@injectable
class WeatherCubit extends Cubit<WeatherState> {
  final WeatherUseCase _weatherUseCase;

  WeatherCubit(this._weatherUseCase) : super(const WeatherInitialState());

  // Cities we would use
  static const Map<String, Map<String, double>> cities = {
    'Riyadh, Saudi Arabia': {'lat': 24.7136, 'lon': 46.6753},
    'Jeddah, Saudi Arabia': {'lat': 21.5433, 'lon': 39.1728},
    'Dammam, Saudi Arabia': {'lat': 26.4207, 'lon': 50.0888},
    'Abha, Saudi Arabia': {'lat': 18.2164, 'lon': 42.5053},
  };

  Future<void> loadAllCitiesWeather() async {
    emit(const WeatherLoadingState());

    final Map<String, WeatherEntity> weatherData = {};
    String? errorMessage;

    for (final entry in cities.entries) {
      final cityName = entry.key;
      final coords = entry.value;

      final result = await _weatherUseCase.getWeather(
        lat: coords['lat']!,
        lon: coords['lon']!,
      );

      result.fold(
        (error) {
          errorMessage = error;
        },
        (weather) {
          weatherData[cityName] = weather;
        },
      );
    }

    if (weatherData.isEmpty) {
      emit(WeatherErrorState(
        message: errorMessage ?? 'Failed to load weather data',
      ));
    } else {
      emit(WeatherLoadedState(
        weatherData: weatherData,
        errorMessage: errorMessage,
      ));
    }
  }

  void filterCities(String query) {
    final currentState = state;
    if (currentState is WeatherLoadedState) {
      emit(WeatherLoadedState(
        weatherData: currentState.weatherData,
        errorMessage: currentState.errorMessage,
        searchQuery: query,
      ));
    }
  }

  void removeCity(String cityName) {
    final currentState = state;
    if (currentState is WeatherLoadedState) {
      final updatedWeatherData = Map<String, WeatherEntity>.from(currentState.weatherData);
      updatedWeatherData.remove(cityName);

      emit(WeatherLoadedState(
        weatherData: updatedWeatherData,
        errorMessage: currentState.errorMessage,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  Future<void> addCity(String cityName) async {
    if (cityName.trim().isEmpty) {
      return;
    }

    final currentState = state;
    final currentWeatherData = currentState is WeatherLoadedState
        ? currentState.weatherData
        : <String, WeatherEntity>{};

    emit(const WeatherLoadingState());

    final result = await _weatherUseCase.getWeatherByCity(
      cityName: cityName.trim(),
    );

    result.fold(
      (error) {
        if (currentWeatherData.isNotEmpty) {
          emit(WeatherLoadedState(
            weatherData: currentWeatherData,
            errorMessage: error,
          ));
        } else {
          emit(WeatherErrorState(message: error));
        }
      },
      (weather) {
        final updatedWeatherData = Map<String, WeatherEntity>.from(currentWeatherData);
        updatedWeatherData[cityName.trim()] = weather;

        emit(WeatherLoadedState(
          weatherData: updatedWeatherData,
          errorMessage: null,
        ));
      },
    );
  }
}
