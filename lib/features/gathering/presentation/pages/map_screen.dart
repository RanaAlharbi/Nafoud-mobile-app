import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
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

    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Map of Events"),
          backgroundColor: Color(0xFF656A53),
        ),

        body: Stack(
          children: [
            BlocBuilder<GatheringCubit, GatheringState>(
              builder: (context, state) {
                if (state is GatheringLoading) {
                  return const Center(child: CircularProgressIndicator());
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
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            userAgentPackageName: "com.example.final_project",
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
                                    color: Colors.white,
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

                return SizedBox.shrink();
              },
            ),

            
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search events...",
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    cubit.search(value);
                  },
                ),
              ),
            ),

       
            Positioned(
              bottom: 30,
              right: 20,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: "zoomIn",
                    mini: true,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.add, color: Colors.black),
                    onPressed: () {
                      zoomNotifier.value += 1;
                      mapController.move(
                        mapController.camera.center,
                        zoomNotifier.value,
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton(
                    heroTag: "zoomOut",
                    mini: true,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.remove, color: Colors.black),
                    onPressed: () {
                      zoomNotifier.value -= 1;
                      mapController.move(
                        mapController.camera.center,
                        zoomNotifier.value,
                      );
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
        return Icons.museum;
      case "Sports":
        return Icons.sports_soccer;
      case "Arts":
        return Icons.color_lens;
      case "Entertainment":
        return Icons.music_note;
      default:
        return Icons.location_on;
    }
  }

  Color _getMarkerColor(String category) {
    switch (category) {
      case "Cultural":
        return Color(0xFFC9A57A);
      case "Sports":
        return Color(0xFF6A5ACD);
      case "Arts":
        return Color(0xFF4CAF50);
      case "Entertainment":
        return Color(0xFF0084FF);
      default:
        return Colors.grey;
    }
  }
}



Future<LatLng?> searchLocation(String query) async {
  final url = Uri.parse(
    "https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1"
  );

  final response = await http.get(url, headers: {
    "User-Agent": "FlutterApp"
  });

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