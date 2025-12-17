import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/features/events/presentation_layer/utils/event_category_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';
import 'package:final_project/core/shared/utils/map_utils.dart';

class EventMapWidget extends StatelessWidget {
  final EventEntity event;

  const EventMapWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final lat = event.latitude;
    final lng = event.longitude;

    // If there is no location
    if (lat == null || lng == null) {
      return Text(
        "events.locationNotAvailable".tr(),
        style: GoogleFonts.cairo(color: Colors.grey),
      );
    }

    final point = LatLng(lat, lng);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 300, // Size of the map
        child: Stack(
          children: [
            RepaintBoundary(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(target: point, zoom: 25),
                markers: {
                  Marker(
                    markerId: const MarkerId("eventLocation"),
                    position: point, // The marker position - based on lat/lng
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed, // Similar to Google marker
                    ),
                  ),
                },
                zoomControlsEnabled: false, // Zoom buttons
                myLocationButtonEnabled: false,
                compassEnabled: false, // Compass on top of map
                mapToolbarEnabled: false, // To get direction toolbar
                liteModeEnabled: false, // Disabled for full interactive map
              ),
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
                          colorFilter: ColorFilter.mode(
                            EventCategoryUtils.getCategoryColor(event.category),
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            event.location ?? '',
                            style: GoogleFonts.cairo(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
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
                        color: EventCategoryUtils.getCategoryColor(
                          event.category,
                        ),
                        onPressed: () => MapLauncher.openGoogleMaps(lat, lng),
                        child: Text(
                          "events.getDirections".tr(),
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
