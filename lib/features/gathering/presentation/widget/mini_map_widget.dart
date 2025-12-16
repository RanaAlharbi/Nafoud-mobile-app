import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MiniGoogleMapWidget extends StatelessWidget {
  final double lat;
  final double lng;

  const MiniGoogleMapWidget({super.key, required this.lat, required this.lng});

  @override
  Widget build(BuildContext context) {
    final LatLng point = LatLng(lat, lng);

    return Container(
      height: 150,
      margin: const EdgeInsets.only(top: 6, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF656A53)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: point, zoom: 15),
          markers: {
            Marker(
              markerId: const MarkerId("miniMapLocation"),
              position: point,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
            ),
          },
          zoomGesturesEnabled: false,
          scrollGesturesEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,

          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          compassEnabled: false,
          mapToolbarEnabled: false,

          liteModeEnabled: true,
        ),
      ),
    );
  }
}
