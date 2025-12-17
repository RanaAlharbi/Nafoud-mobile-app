import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:final_project/features/weather/domain/entities/weather_entity.dart';
import 'package:final_project/features/weather/presentation/widgets/weather_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class WeatherCard extends StatelessWidget {
  final String cityName;
  final WeatherEntity weather;

  const WeatherCard({
    super.key,
    required this.cityName,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side - Temperature and location info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Temperature
                Text(
                  '${_formatTemp(weather.temp)}°',
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                Gap(4.h),
                // High/Low temperatures
                Text(
                  '${'weather.high'.tr()}:${_formatTemp(weather.tempMax)}°  ${'weather.low'.tr()}:${_formatTemp(weather.tempMin)}°',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color.fromRGBO(30, 30, 30, 0.6),
                  ),
                ),
                Gap(8.h),
                // City name
                Text(
                  cityName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(30, 30, 30, 1),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Gap(12.w),
          // Right side - Weather icon and condition
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              WeatherIconWidget(iconCode: weather.weatherIcon),
              Gap(4.h),
              Text(
                _getWeatherConditionText(weather.weatherMain),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(30, 30, 30, 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTemp(double temp) {
    if (temp.isNaN || temp.isInfinite) {
      return '--';
    }
    return temp.round().toString();
  }

  String _getWeatherConditionText(String condition) {
    switch (condition.toLowerCase()) {
      case 'rain':
      case 'drizzle':
        return 'weather.conditions.rainy'.tr();
      case 'clouds':
        return 'weather.conditions.cloudy'.tr();
      case 'clear':
        return 'weather.conditions.sunny'.tr();
      case 'snow':
        return 'weather.conditions.snowy'.tr();
      case 'thunderstorm':
        return 'weather.conditions.stormy'.tr();
      default:
        return condition;
    }
  }
}
