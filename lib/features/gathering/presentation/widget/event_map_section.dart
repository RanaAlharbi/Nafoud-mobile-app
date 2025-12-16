import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:final_project/core/shared/utils/map_utils.dart';

class EventMapSection extends StatelessWidget {
  final GatheringEntity event;

  const EventMapSection({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final lat = event.latitude;
    final lng = event.longitude;

//if there is no location

    if (lat == null || lng == null) {
      return  Text(
        "Location not available",
        style: GoogleFonts.cairo(color: Colors.grey),
      );
    }

    final point = LatLng(lat, lng);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 300, //size of the map
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: point,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("eventLocation"),
                  position: point, //the marker position - based on lang - lat
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed, //similar to google marker
                  ),
                ),
              },
              zoomControlsEnabled: false, //zooms button
              myLocationButtonEnabled: false,
              compassEnabled: false, // البوصلة اللي فوق بالخريطة مااعرف اسمها بالانجليزي
              mapToolbarEnabled: false, //to get direction
            ),

            Positioned(
              bottom: 16,
              left: 16.w,
              right: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: const Color(0xffF0F0EE),
                  borderRadius: BorderRadius.circular(20.r),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/location.svg',
                          width: 21.w,
                          height: 21.h,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            event.address,
                            style: GoogleFonts.cairo(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF3A3A3A),
                            ),
                          ),
                        ),
                      ],
                    ),

                    12.verticalSpace,

                    SizedBox(
                      height: 48.h,
                      width: double.infinity,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.circular(20.r),
                        color: const Color(0xFF656A53),
                        onPressed: () => MapLauncher.openGoogleMaps(
                          lat,
                          lng,
                        ),
                        child: Text(
                          "Get Directions",
                          style: GoogleFonts.cairo(
                            color: const Color(0xffF0F0EE),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
