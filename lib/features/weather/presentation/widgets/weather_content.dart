import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:final_project/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:final_project/features/weather/presentation/cubit/weather_state.dart';
import 'package:final_project/features/weather/presentation/widgets/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WeatherContent extends StatelessWidget {
  final WeatherState state;

  const WeatherContent({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state is WeatherLoadingState) {
      // Show shimmer loading cards
      return ListView.separated(
        itemCount: 6,
        separatorBuilder: (context, index) => Gap(12.h),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side shimmer
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Temperature shimmer
                      Shimmer(
                        duration: Duration(milliseconds: 800),
                        color: AppColors.primaryColor,
                        child: Container(
                          width: 120.w,
                          height: 78.h,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(241, 241, 241, 1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                      Gap(4.h),
                      // High/Low shimmer
                      Shimmer(
                        duration: Duration(milliseconds: 800),
                        color: AppColors.primaryColor,
                        child: Container(
                          width: 80.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(241, 241, 241, 1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      Gap(8.h),
                      // City name shimmer
                      Shimmer(
                        duration: Duration(milliseconds: 800),
                        color: AppColors.primaryColor,
                        child: Container(
                          width: 100.w,
                          height: 16.h,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(241, 241, 241, 1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(12.w),
                // Right side shimmer
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Weather icon shimmer
                    ClipOval(
                      child: Shimmer(
                        duration: Duration(milliseconds: 800),
                        color: AppColors.primaryColor,
                        child: Container(
                          width: 90.w,
                          height: 90.w,
                          color: Color.fromRGBO(241, 241, 241, 1),
                        ),
                      ),
                    ),
                    Gap(23.h),
                    // Condition text shimmer
                    Shimmer(
                      duration: Duration(milliseconds: 800),
                      color: AppColors.primaryColor,
                      child: Container(
                        width: 60.w,
                        height: 13.h,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(241, 241, 241, 1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
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