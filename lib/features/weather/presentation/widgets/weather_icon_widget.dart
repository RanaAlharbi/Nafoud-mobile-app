import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherIconWidget extends StatelessWidget {
  final String iconCode;

  const WeatherIconWidget({
    super.key,
    required this.iconCode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: CachedNetworkImage(
        imageUrl: 'https://openweathermap.org/img/wn/$iconCode@2x.png',
        fit: BoxFit.contain,
        placeholder: (context, url) => Center(
          child: SizedBox(
            width: 30.w,
            height: 30.h,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) =>
            Icon(Icons.cloud, size: 60.sp, color: Colors.grey),
      ),
    );
  }
}
