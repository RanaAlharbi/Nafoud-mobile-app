import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class BuildQuickGuideItemWidget extends StatelessWidget {
  const BuildQuickGuideItemWidget({
    super.key,
    required this.svgPath,
    required this.label,
    required this.onTap,
  });

  final String svgPath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: SizedBox(
        width: 96.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Outer container (the one on the back and have green color)
                Container(
                  width: 75.w,
                  height: 75.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                // original container
                Container(
                  width: 73.w,
                  height: 73.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.83),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      svgPath,
                      width: 32.w,
                      height: 32.w,
                      fit: BoxFit.contain,
                      allowDrawingOutsideViewBox: false,
                    ),
                  ),
                ),
              ],
            ),
            Gap(8.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
