import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverWidget extends StatelessWidget {
  const DiscoverWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Text(
            'Discover  ',
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          DropdownButton<String>(
            value: 'All Destinations',
            underline: SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down),
            iconEnabledColor: AppColors.primaryColor,
            style: TextStyle(
              fontSize: 25.sp,
              color: AppColors.primaryColor,
            ),
            items: [
              DropdownMenuItem(
                value: 'All Destinations',
                child: Text('All Destinations'),
              ),
              DropdownMenuItem(
                value: 'Riyadh',
                child: Text('Riyadh'),
              ),
              DropdownMenuItem(
                value: 'Jeddah',
                child: Text('Jeddah'),
              ),
              DropdownMenuItem(
                value: 'Dammam',
                child: Text('Dammam'),
              ),
              DropdownMenuItem(
                value: 'Medina',
                child: Text('Medina'),
              ),
            ],
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
