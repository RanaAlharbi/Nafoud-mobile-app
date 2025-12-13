import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_plus/share_plus.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GatheringDetailsScreen extends StatelessWidget {
  final GatheringEntity event;

  const GatheringDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    context.read<GatheringCubit>().loadParticipants(event.id!);

    return BlocListener<GatheringCubit, GatheringState>(
      listener: (context, state) {
        if (state is GatheringMessage) {
          showCupertinoDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: const Text("Notice"),
              content: Text(state.message),
              actions: [
                CupertinoDialogAction(
                  child: const Text("OK"),
                  isDefaultAction: true,
                  onPressed: () => context.pop("refresh")
                ),
              ],
            ),
          );
        }
      },

      child: CupertinoPageScaffold(
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
            onPressed: () => context.pop("refresh")
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
          
            
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: event.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.55),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 16,
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            BlocBuilder<GatheringCubit, GatheringState>(
                              builder: (context, state) {
                                if (state is GatheringParticipantsLoaded &&
                                    state.avatars.isNotEmpty) {
                                  final avatars = state.avatars;
                                  final visible = avatars.take(5).toList();
                                  final remaining =
                                      avatars.length - visible.length;

                                  return Row(
                                    children: [
                                      for (int i = 0; i < visible.length; i++)
                                        Container(
                                          margin: const EdgeInsets.only(
                                            right: 6,
                                          ),
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: Colors.white
                                                .withOpacity(0.85),
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundImage: NetworkImage(
                                                visible[i],
                                              ),
                                            ),
                                          ),
                                        ),

                                      if (remaining > 0)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.85,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Text(
                                            "+$remaining",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        right: 16,
                        bottom: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            event.category,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3D4032),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _infoRow(CupertinoIcons.calendar, event.date),
                      const SizedBox(height: 12),
                      _infoRow(CupertinoIcons.time, event.eventTime),
                      const SizedBox(height: 12),
                      _infoRow(CupertinoIcons.location_solid, event.city),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildMapSection(),
                ),

                const SizedBox(height: 30),

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
                    onPressed: () {
                      context.read<GatheringCubit>().joinEvent(event.id!);
                    },
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF6B6F52)),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Color(0xFF3A3A3A)),
        ),
      ],
    );
  }

  Widget _buildMapSection() {
    final lat = double.tryParse(event.latitude.toString());
    final lng = double.tryParse(event.longitude.toString());

    if (lat == null || lng == null) {
      return const Text(
        "Location not available",
        style: TextStyle(color: CupertinoColors.systemGrey),
      );
    }

    final point = LatLng(lat, lng);

    return ClipRRect(
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
    );
  }

  void _shareEvent() {
    final lat = event.latitude;
    final lng = event.longitude;

    final text =
        """
${event.title}

📅 ${event.date}
⏰ ${event.eventTime}
📍 ${event.city}

Open in Google Maps:
https://www.google.com/maps/search/?api=1&query=$lat,$lng
""";

    SharePlus.instance.share(ShareParams(text: text));
  }
}
