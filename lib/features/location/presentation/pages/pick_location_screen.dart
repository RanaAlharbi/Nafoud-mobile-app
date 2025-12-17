import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';

class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({super.key});

  static const _defaultLat = 24.7136;
  static const _defaultLng = 46.6753;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LocationCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Location",
          style: GoogleFonts.cairo(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xff3D4032),
          ),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<LocationCubit, LocationState>(
            builder: (_, state) {
              return TextButton(
                onPressed: state.lat != null
                    ? () {
                        Navigator.pop(context, {
                          "lat": state.lat,
                          "lng": state.lng,
                        });
                      }
                    : null,
                child: Text(
                  "Done",
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.khuzamaColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          //map
          BlocBuilder<LocationCubit, LocationState>(
            builder: (_, state) {
              final lat = state.lat ?? _defaultLat;
              final lng = state.lng ?? _defaultLng;

              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: 13,
                ),
                onMapCreated: cubit.setMapController,
                onTap: (point) {
                  cubit.setManualLocation(point.latitude, point.longitude);
                },
                markers: state.lat != null
                    ? {
                        Marker(
                          markerId: const MarkerId("selected_location"),
                          position: LatLng(state.lat!, state.lng!),
                        ),
                      }
                    : {},
              );
            },
          ),

          //search box
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                onChanged: cubit.search,
                decoration: InputDecoration(
                  hintText: "Search for a place",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),

          ///search results
          BlocBuilder<LocationCubit, LocationState>(
            builder: (_, state) {
              if (state.loading || state.results.isEmpty) {
                return const SizedBox.shrink();
              }

              return Positioned(
                top: 80,
                left: 16,
                right: 16,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 260),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.results.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final item = state.results[i];
                        return ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(item.description),
                          onTap: () {
                            cubit.selectPlace(item.placeId);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
