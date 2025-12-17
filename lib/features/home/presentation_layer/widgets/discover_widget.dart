import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
class DiscoverWidget extends StatelessWidget {
  final String selectedDestination;
  final ValueChanged<String?> onDestinationChanged;

  const DiscoverWidget({
    super.key,
    required this.selectedDestination,
    required this.onDestinationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Text(
            'home.discover'.tr(),
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 8.w),
          DropdownButton<String>(
            value: selectedDestination,
            underline: SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down),
            iconEnabledColor: AppColors.primaryColor,
            menuMaxHeight: 190.h,
            borderRadius: BorderRadius.circular(15.r),
            style: TextStyle(fontSize: 25.sp, color: AppColors.primaryColor),
            items: [
              DropdownMenuItem(
                value: 'All Destinations',
                child: Text('home.all_destinations'.tr(), style: TextStyle(fontSize: 18.sp, color: AppColors.primaryColor)),
              ),
              DropdownMenuItem(
                value: 'Riyadh',
                child: Text('home.riyadh'.tr(), style: TextStyle(fontSize: 18.sp, color: AppColors.primaryColor)),
              ),
              DropdownMenuItem(
                value: 'Jeddah',
                child: Text('home.jeddah'.tr(), style: TextStyle(fontSize: 18.sp, color: AppColors.primaryColor)),
              ),
              DropdownMenuItem(
                value: 'Dammam',
                child: Text('home.dammam'.tr(), style: TextStyle(fontSize: 18.sp, color: AppColors.primaryColor)),
              ),
              DropdownMenuItem(
                value: 'Medina',
                child: Text('home.medina'.tr(), style: TextStyle(fontSize: 18.sp, color: AppColors.primaryColor)),
              ),
            ],
            onChanged: onDestinationChanged,
          ),
        ],
      ),
    );
  }
}
