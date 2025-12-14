import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmergencySearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const EmergencySearchBar({
    super.key,
    this.onChanged,
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
          hintText: 'Search ...',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 18.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
