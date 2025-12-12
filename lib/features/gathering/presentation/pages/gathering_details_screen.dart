import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class GatheringDetailsScreen extends StatelessWidget {
  final GatheringEntity event;

  const GatheringDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF9F9F9),

      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        middle: Text(
          event.category,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3D4032),
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back, color: Color(0xFF3D4032)),
          onPressed: () => Navigator.pop(context),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.share, color: Color(0xFF3D4032)),
          onPressed: () => _shareEvent(),
        ),
      ),

      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE
              CachedNetworkImage(
                imageUrl: event.imageUrl,
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(height: 260, color: CupertinoColors.systemGrey4),
                errorWidget: (_, __, ___) => Container(
                  height: 260,
                  color: CupertinoColors.systemGrey4,
                  child: const Icon(CupertinoIcons.exclamationmark_triangle),
                ),
              ),

              const SizedBox(height: 20),

              // TITLE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3D4032),
                  ),
                ),
              ),

              // DESCRIPTION
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  event.description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: Color(0xFF4D4D4D),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // INFO TITLE
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3D4032),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // INFORMATION ROWS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _infoRow(CupertinoIcons.calendar, event.date),
                    const SizedBox(height: 12),
                    _infoRow(CupertinoIcons.time, event.eventTime),
                    const SizedBox(height: 12),
                    _infoRow(CupertinoIcons.location, event.city),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // MAP SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildMapSection(),
              ),

              const SizedBox(height: 30),

              // JOIN BUTTON
              Center(
                child: CupertinoButton(
                  color: const Color(0xFF656A53),
                  borderRadius: BorderRadius.circular(14),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 12,
                  ),
                  child: const Text(
                    "Joining",
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------
  // SMALL INFO ROW
  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Color(0xFF6B6F52)),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Color(0xFF3A3A3A)),
        ),
      ],
    );
  }

  // ---------------------------------------------
  // MAP SECTION
  Widget _buildMapSection() {
    final lat = double.tryParse(event.latitude.toString());
    final lng = double.tryParse(event.longitude.toString());

    if (lat == null || lng == null) {
      return const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          "Location not available",
          style: TextStyle(color: CupertinoColors.systemGrey),
        ),
      );
    }

    final point = LatLng(lat, lng);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 300,
            child: FlutterMap(
              options: MapOptions(initialCenter: point, initialZoom: 12),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'final_project_app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: point,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        CupertinoIcons.location_solid,
                        size: 40,
                        color: CupertinoColors.systemRed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // FLOATING CARD
        Positioned(
          bottom: 12,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.location,
                      color: Color(0xFF656A53),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A4A41),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(12),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  onPressed: _openInGoogleMaps,
                  child: const Text(
                    "Get Directions",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------
  // SHARE
  void _shareEvent() {
    final lat = event.latitude;
    final lng = event.longitude;

    final appLink = "myapp://event/${event.id}";
    final mapLink = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";

    final text =
        """
${event.title}

📅 ${event.date}
⏰ ${event.eventTime}
📍 ${event.city}

View this event in the app:
$appLink

Open location in Google Maps:
$mapLink
""";

    SharePlus.instance.share(ShareParams(text: text));
  }

  // ---------------------------------------------
  // OPEN GOOGLE MAPS
  void _openInGoogleMaps() async {
    final lat = double.tryParse(event.latitude.toString());
    final lng = double.tryParse(event.longitude.toString());
    if (lat == null || lng == null) return;

    final url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
