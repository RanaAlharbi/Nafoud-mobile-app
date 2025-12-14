import 'package:final_project/core/shared/utils/map_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';

class EventMapSection extends StatelessWidget {
  final GatheringEntity event;

  const EventMapSection({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final lat = event.latitude;
    final lng = event.longitude;

    if (lat == null || lng == null) {
      return const Text(
        "Location not available",
        style: TextStyle(color: Colors.grey),
      );
    }

    final point = LatLng(lat, lng);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 300,
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(initialCenter: point, initialZoom: 14),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'final_project',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: point,
                      width: 40.w,
                      height: 40.h,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),

                decoration: BoxDecoration(
                  color: Color(0xffF0F0EE),
                  borderRadius: BorderRadius.circular(20),
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
                              fontSize: 17,
                              fontWeight: .normal,
                              color: Color(0xFF3A3A3A),
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
                        ), //open google map
                        child: Text(
                          "Get Directions",
                          style: TextStyle(
                            color: Color(0xffF0F0EE),
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
