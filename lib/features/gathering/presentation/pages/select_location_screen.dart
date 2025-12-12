import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';

class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GatheringCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Activity Location"),
        actions: [
          TextButton(
            onPressed: cubit.selectedLat == null
                ? null
                : () {
                    Navigator.pop(context, {
                      "lat": cubit.selectedLat,
                      "lng": cubit.selectedLng,
                    });
                  },
            child: const Text("Done"),
          )
        ],
      ),

      body: BlocBuilder<GatheringCubit, GatheringState>(
        builder: (context, state) {
          return FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                cubit.selectedLat ?? 24.7136,
                cubit.selectedLng ?? 46.6753,
              ),
              initialZoom: 12,
              onTap: (tapPosition, point) {
                cubit.updateTempLocation(point.latitude, point.longitude);
              },
            ),
            children: [
            TileLayer(
  urlTemplate: "https://a.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png",
  userAgentPackageName: 'com.example.app',
),

              if (cubit.selectedLat != null && cubit.selectedLng != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 40,
                      height: 40,
                      point: LatLng(cubit.selectedLat!, cubit.selectedLng!),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    )
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
