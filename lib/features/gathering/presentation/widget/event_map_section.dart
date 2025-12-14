import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';

class EventMapSection extends StatelessWidget {
  final GatheringEntity event;

  const EventMapSection({super.key, required this.event});

  void _openMaps(double lat, double lng) async {
    final url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lat = event.latitude;
    final lng = event.longitude;

    if (lat == null || lng == null) {
      return const Text("Location not available",
          style: TextStyle(color: Colors.grey));
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
                      width: 40,
                      height: 40,
                      child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                    ),
                  ],
                ),
              ],
            ),

            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF656A53),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () => _openMaps(lat, lng),
                child: const Text("Get Directions",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
