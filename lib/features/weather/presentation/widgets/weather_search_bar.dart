import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const WeatherSearchBar({
    super.key,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey, width: 1.5),
      ),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.search, color: Colors.grey, size: 20.sp),
          hintText: 'Search Location ...',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 18.sp),
          border: InputBorder.none,
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
