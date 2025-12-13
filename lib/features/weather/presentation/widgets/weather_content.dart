import 'package:final_project/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:final_project/features/weather/presentation/cubit/weather_state.dart';
import 'package:final_project/features/weather/presentation/widgets/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class WeatherContent extends StatelessWidget {
  final WeatherState state;

  const WeatherContent({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state is WeatherLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is WeatherErrorState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
            Gap(16.h),
            Text(
              (state as WeatherErrorState).message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: Colors.red),
            ),
            Gap(24.h),
            ElevatedButton(
              onPressed: () {
                context.read<WeatherCubit>().loadAllCitiesWeather();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    } else if (state is WeatherLoadedState) {
      final loadedState = state as WeatherLoadedState;
      final weatherData = loadedState.filteredWeatherData;

      if (weatherData.isEmpty) {
        return Center(
          child: Text(
            loadedState.searchQuery.isEmpty
              ? 'No weather data available'
              : 'No cities found matching "${loadedState.searchQuery}"',
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color.fromRGBO(30, 30, 30, 0.5),
            ),
            textAlign: TextAlign.center,
          ),
        );
      }

      return ListView.separated(
        itemCount: weatherData.length,
        separatorBuilder: (context, index) => Gap(12.h),
        itemBuilder: (context, index) {
          final entry = weatherData.entries.elementAt(index);
          final cityName = entry.key;
          final weather = entry.value;

          return WeatherCard(
            cityName: cityName,
            weather: weather,
          );
        },
      );
    }

    // Initial state
    return Center(
      child: Text(
        'Loading weather data...',
        style: TextStyle(
          fontSize: 16.sp,
          color: const Color.fromRGBO(30, 30, 30, 0.5),
        ),
      ),
    );
  }
}