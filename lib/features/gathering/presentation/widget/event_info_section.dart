import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EventInfo extends StatelessWidget {
  final GatheringEntity event;

  const EventInfo({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //date of event
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/date.svg',
              width: 23.w,
              height: 23.h,
            ),
            7.horizontalSpace,
            Expanded(
              child: Text(
                event.date,
                style: GoogleFonts.cairo(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),

        12.verticalSpace,

        // time of event
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/clock.svg',
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                event.eventTime,
                style: GoogleFonts.cairo(
                  fontSize: 15, 
                  color:Colors.black,
              ),
            ),
            )
          ],
        ),

        12.verticalSpace,

        // location of the event
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/location.svg',
              width: 24.w,
              height: 24.h,
            ),
            10.horizontalSpace,
            Expanded(
              child: Text(
                event.city,
                style: GoogleFonts.cairo(
                  fontSize: 15, 
                  color: Colors.black,
              ),
            ),
            )
          ],
        ),
      ],
    );
  }
}
