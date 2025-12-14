import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class EventDetailsCupertinoScreen extends StatelessWidget {
  final GatheringEntity event;

  const EventDetailsCupertinoScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
  
    context.read<GatheringCubit>().loadParticipants(event.id!);

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F5F3),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        middle: Text(
          event.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3D4032),
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          child: const Icon(CupertinoIcons.back, color: Color(0xFF3D4032)),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _shareEvent(),
          child: const Icon(CupertinoIcons.share, color: Color(0xFF3D4032)),
        ),
      ),

      // MAIN CONTENT
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // HEADER
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),

         
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3D4032),
                      ),
                    ),

                    const SizedBox(height: 14),

                   
                    Text(
                      event.description,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Color(0xFF555555),
                      ),
                    ),

                    const SizedBox(height: 30),

                   
                    const Text(
                      "Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF3D4032),
                      ),
                    ),

                    const SizedBox(height: 14),

                    _infoRow(CupertinoIcons.calendar, event.date),
                    const SizedBox(height: 10),
                    _infoRow(CupertinoIcons.time, event.eventTime),
                    const SizedBox(height: 10),
                    _infoRow(CupertinoIcons.location_solid, event.city),

                    const SizedBox(height: 30),

                    // MAP
                    const Text(
                      "Location",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF3D4032),
                      ),
                    ),
                    const SizedBox(height: 10),

                    _buildMapSection(),

                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),

            // Bottom Join Button
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _joinButton(context),
                  const SizedBox(height: 30),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _buildHeader() {
    return Container(
      height: 320,
      child: Stack(
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
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.55),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Avatars
          Positioned(
            bottom: 25,
            left: 20,
            child: BlocBuilder<GatheringCubit, GatheringState>(
              builder: (context, state) {
                if (state is GatheringParticipantsLoaded &&
                    state.avatars.isNotEmpty) {
                  final list = state.avatars.take(5).toList();
                  final more = state.avatars.length - list.length;

                  return Row(
                    children: [
                      for (final img in list)
                        Container(
                          margin: const EdgeInsets.only(right: 6),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(img),
                          ),
                        ),
                      if (more > 0)
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text("+$more"),
                        )
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }

 
  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 22, color: Color(0xFF6B6F52)),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }


  Widget _buildMapSection() {
    final lat = event.latitude;
    final lng = event.longitude;

    if (lat == null || lng == null) {
      return const Text("Location not available");
    }

    final point = LatLng(lat, lng);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 250,
        child: FlutterMap(
          options: MapOptions(initialCenter: point, initialZoom: 13),
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _joinButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CupertinoButton(
        color: const Color(0xFF6B6F52),
        borderRadius: BorderRadius.circular(14),
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: const Text(
          "Join Event",
          style: TextStyle(
            fontSize: 20,
            color: CupertinoColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {
          context.read<GatheringCubit>().joinEvent(event.id!);
        },
      ),
    );
  }

  // ==============================
  // SHARE
  // ==============================
  void _shareEvent() {
    final link =
        "https://www.google.com/maps/search/?api=1&query=${event.latitude},${event.longitude}";

    final text = """
${event.title}
📅 ${event.date}
⏰ ${event.eventTime}
📍 ${event.city}

Location:
$link
""";

    SharePlus.instance.share(
      ShareParams(text: text),
    );
  }
}
