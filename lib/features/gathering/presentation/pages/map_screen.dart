import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';

class EventsMapScreen extends StatelessWidget {
  final GatheringCubit cubit;

  const EventsMapScreen({super.key, required this.cubit});

  static final ValueNotifier<double> zoomNotifier = ValueNotifier(5);

  @override
  Widget build(BuildContext context) {
    cubit.fetchMapEvents();
    final MapController mapController = MapController();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Map of Events",
          style: GoogleFonts.cairo(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xff3D4032),
          ),
        ),
        backgroundColor: const Color(0xFFF8F8F8),
      ),

      child: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<GatheringCubit, GatheringState>(
              builder: (context, state) {
                if (state is GatheringLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }

                if (state is GatheringError) {
                  return Center(child: Text(state.message));
                }

                if (state is GatheringLoaded) {
                  final events = state.events;
                  final mapCenter = _calculateCenter(events);

                  return ValueListenableBuilder<double>(
                    valueListenable: zoomNotifier,
                    builder: (context, zoom, _) {
                      return FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          initialCenter: mapCenter,
                          initialZoom: zoom,
                          minZoom: 2,
                          maxZoom: 18,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            userAgentPackageName:
                                "com.example.final_project",
                            maxNativeZoom: 19,
                            minNativeZoom: 0,
                          ),

                          MarkerLayer(
                            markers: events.map((e) {
                              final icon = _getMarkerIcon(e.category);
                              final color = _getMarkerColor(e.category);

                              return Marker(
                                point: LatLng(e.latitude!, e.longitude!),
                                width: 50,
                                height: 50,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: color,
                                  ),
                                  child: Icon(
                                    icon,
                                    color: CupertinoColors.white,
                                    size: 26,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            // --- Search Bar ---
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CupertinoSearchTextField(
                  placeholder: "Search events...",
                  backgroundColor: CupertinoColors.white,
                  onChanged: (value) => cubit.search(value),
                ),
              ),
            ),

            // --- Zoom Buttons ---
            Positioned(
              bottom: 30,
              right: 20,
              child: Column(
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.black.withValues(alpha: 0.2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(CupertinoIcons.plus, color: Colors.black),
                    ),
                    onPressed: () {
                      if (zoomNotifier.value < 18) {
                        zoomNotifier.value += 1;
                        mapController.move(
                          mapController.camera.center,
                          zoomNotifier.value,
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 12),

                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.black.withValues(alpha: 0.2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child:
                          const Icon(CupertinoIcons.minus, color: Colors.black),
                    ),
                    onPressed: () {
                      if (zoomNotifier.value > 2) {
                        zoomNotifier.value -= 1;
                        mapController.move(
                          mapController.camera.center,
                          zoomNotifier.value,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  LatLng _calculateCenter(List events) {
    if (events.isEmpty) return LatLng(23.8859, 45.0792);

    double avgLat = 0;
    double avgLng = 0;

    for (var e in events) {
      avgLat += e.latitude!;
      avgLng += e.longitude!;
    }

    return LatLng(avgLat / events.length, avgLng / events.length);
  }

  IconData _getMarkerIcon(String category) {
    switch (category) {
      case "Cultural":
        return CupertinoIcons.book;
      case "Sports":
        return CupertinoIcons.sportscourt;
      case "Arts":
        return CupertinoIcons.paintbrush;
      case "Entertainment":
        return CupertinoIcons.music_note;
      default:
        return CupertinoIcons.location_solid;
    }
  }

  Color _getMarkerColor(String category) {
    switch (category) {
      case "Cultural":
        return const Color(0xFFC2A480);
      case "Sports":
        return const Color(0xFF6C62A5);
      case "Arts":
        return const Color(0xFF656A53);
      case "Entertainment":
        return const Color.fromARGB(255, 156, 146, 209);
      default:
        return CupertinoColors.systemGrey;
    }
  }
}

Future<LatLng?> searchLocation(String query) async {
  final url = Uri.parse(
    "https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1",
  );

  final response = await http.get(url, headers: {"User-Agent": "FlutterApp"});

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data.isNotEmpty) {
      final lat = double.parse(data[0]["lat"]);
      final lon = double.parse(data[0]["lon"]);
      return LatLng(lat, lon);
    }
  }
  return null;
}
