import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';

class SelectLocationScreen extends StatelessWidget {
  SelectLocationScreen({super.key});

  final TextEditingController _searchCtrl = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<GatheringCubit>();

    return Scaffold(
 
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<GatheringCubit, GatheringState>(
          builder: (context, state) {
            final isEnabled = cubit.selectedLat != null;

            return AppBar(
              title: const Text("Pick Activity Location"),
              actions: [
                TextButton(
                  onPressed: isEnabled
                      ? () {
                          Navigator.pop(context, {
                            "lat": cubit.selectedLat,
                            "lng": cubit.selectedLng,
                          });
                        }
                      : null,
                  child: Text(
                    "Done",
                    style: TextStyle(
                      color: isEnabled ? Colors.blue : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),

      body: Column(
        children: [
       
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: "Search location...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (value) async {
                final result = await searchLocation(value);
                if (result != null) {
                  cubit.updateTempLocation(result.latitude, result.longitude);
                }
              },
            ),
          ),

       
          Expanded(
            child: BlocBuilder<GatheringCubit, GatheringState>(
              builder: (context, state) {
                final lat = cubit.selectedLat ?? 24.7136;
                final lng = cubit.selectedLng ?? 46.6753;

                return FlutterMap(
                  key: ValueKey("$lat-$lng"),
                  options: MapOptions(
                    initialCenter: LatLng(lat, lng),
                    initialZoom: 15,
                    onTap: (tapPosition, point) {
                      cubit.updateTempLocation(point.latitude, point.longitude);
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'com.example.final_project',
                    ),

                    if (cubit.selectedLat != null && cubit.selectedLng != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(
                              cubit.selectedLat!,
                              cubit.selectedLng!,
                            ),
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
