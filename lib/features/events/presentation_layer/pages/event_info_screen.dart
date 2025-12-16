import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class EventInfoScreen extends StatelessWidget {
  final EventEntity event;

  const EventInfoScreen({super.key, required this.event});

  // Method to get category image path
  String _getCategoryImagePath(String? category) {
    if (category == null) return 'assets/Images/events/Empty.svg';

    switch (category.toLowerCase()) {
      case 'shopping':
        return 'assets/Images/events/Shopping.svg';
      case 'sport':
        return 'assets/Images/events/Sport.svg';
      case 'concerts':
        return 'assets/Images/events/Concerts.svg';
      case 'food':
        return 'assets/Images/events/Food.svg';
      case 'cultural & arts':
      case 'cultural and arts':
      case 'cultural':
      case 'arts':
        return 'assets/Images/events/CulturalAndArts.svg';
      default:
        return 'assets/Images/events/Empty.svg';
    }
  }

  // Method to get category display name
  String _getCategoryDisplayName(String? category) {
    if (category == null) return 'Unknown';

    switch (category.toLowerCase()) {
      case 'shopping':
        return 'Shopping';
      case 'sport':
        return 'Sport';
      case 'concerts':
        return 'Concerts';
      case 'food':
        return 'Food';
      case 'cultural & arts':
      case 'cultural and arts':
      case 'cultural':
      case 'arts':
        return 'Cultural & Arts';
      default:
        return 'Unknown';
    }
  }

  // Method to get category color
  Color _getCategoryColor(String? category) {
    if (category == null) return Colors.grey;

    switch (category.toLowerCase()) {
      case 'shopping':
        return const Color(0xFF627BA5);
      case 'sport':
        return AppColors.khuzamaColor;
      case 'concerts':
        return Colors.black;
      case 'food':
        return AppColors.primaryColor;
      case 'cultural & arts':
      case 'cultural and arts':
      case 'cultural':
      case 'arts':
        return AppColors.doohbanColor;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F0EE),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color(0xff3D4032)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Event Details",
          style: GoogleFonts.cairo(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xff3D4032),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Category Icon
            Center(
              child: Container(
                height: 150.h,
                width: 150.w,
                padding: EdgeInsets.all(3.w),
                child: SvgPicture.asset(
                  _getCategoryImagePath(event.category),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Gap(24.h),

            // Event Category Name
            Center(
              child: Text(
                _getCategoryDisplayName(event.category),
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: _getCategoryColor(event.category),
                ),
              ),
            ),

            Gap(32.h),

            // Event Title
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "About ${event.title}",
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: _getCategoryColor(event.category),
                ),
              ),
            ),

            // Event Description
            Container(
              padding: EdgeInsets.all(16.w),
              child: Text(
                event.description ?? "No description available",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
            ),

            Gap(16.h),

            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Information",
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: _getCategoryColor(event.category),
                ),
              ),
            ),

            Gap(16.h),

            // Event Date
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 20.sp,
                    color: _getCategoryColor(event.category),
                  ),
                  Gap(8.w),
                  Text(
                    event.date,
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Event Location
            if (event.location != null) ...[
              Gap(12.h),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 20.sp,
                      color: _getCategoryColor(event.category),
                    ),
                    Gap(8.w),
                    Expanded(
                      child: Text(
                        event.location!,
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Gap(25.h),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Location",
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: _getCategoryColor(event.category),
                ),
              ),
            ),
            Gap(24.h),
          ],
        ),
      ),
    );
  }
}
