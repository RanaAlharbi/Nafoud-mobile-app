import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/weather/domain/use_cases/weather_use_case.dart';
import 'package:final_project/features/weather/presentation/cubit/weather_state.dart';

@injectable
class WeatherCubit extends Cubit<WeatherState> {
  final WeatherUseCase _weatherUseCase;

  WeatherCubit(this._weatherUseCase) : super(WeatherInitialState());

  Future<void> getWeather() async {
    emit(WeatherLoadingState());

    final result = await _weatherUseCase.getWeather();
    result.fold(
      (error) {
        emit(WeatherErrorState(message: error));
      },
      (weather) {
        emit(WeatherLoadedState(weather: weather));
      },
    );
  }
}
