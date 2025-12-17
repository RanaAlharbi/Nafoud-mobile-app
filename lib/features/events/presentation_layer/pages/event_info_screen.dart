import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';
import 'package:final_project/features/events/presentation_layer/utils/event_category_utils.dart';
import 'package:final_project/features/events/presentation_layer/widgets/event_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class EventInfoScreen extends StatelessWidget {
  final EventEntity event;

  const EventInfoScreen({super.key, required this.event});

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
          "events.eventDetails".tr(),
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
                child: Center(
                  child: SvgPicture.asset(
                    EventCategoryUtils.getCategoryImagePath(event.category),
                    width: 120.w,
                    height: 120.h,
                    fit: BoxFit.contain,
                    placeholderBuilder: (context) => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Gap(24.h),

            // Event Category Name
            Center(
              child: Text(
                EventCategoryUtils.getCategoryDisplayName(event.category),
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: EventCategoryUtils.getCategoryColor(event.category),
                ),
              ),
            ),

            Gap(32.h),

            // Event Title
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "events.aboutEvent".tr(namedArgs: {'eventName': event.title}),
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: EventCategoryUtils.getCategoryColor(event.category),
                ),
              ),
            ),

            // Event Description
            Container(
              padding: EdgeInsets.all(16.w),
              child: Text(
                event.description ?? "events.noDescription".tr(),
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
                "events.information".tr(),
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: EventCategoryUtils.getCategoryColor(event.category),
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
                    color: EventCategoryUtils.getCategoryColor(event.category),
                  ),
                  Gap(8.w),
                  Text(
                    event.date,
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),

            Gap(30.h),

            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "events.location".tr(),
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: EventCategoryUtils.getCategoryColor(event.category),
                ),
              ),
            ),

            Gap(16.h),
            // Event Location
            EventMapWidget(event: event),
          ],
        ),
      ),
    );
  }
}
