import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  late FlutterGooglePlacesSdk places;
  gmap.GoogleMapController? mapController;

  final searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  final gmap.LatLng defaultLocation = const gmap.LatLng(24.7136, 46.6753);

  @override
  void initState() {
    super.initState();

    places = FlutterGooglePlacesSdk(
      "AIzaSyBxhdDnhb2FQWFFoNTVHF7FCcj6jZ8ia-I",
      locale: const Locale("en"),
    );
  }

  //search
  Future<void> searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() => searchResults = []);
      return;
    }

    try {
      final response = await places.findAutocompletePredictions(
        query,
        countries: const ["SA"],
      );

      setState(() {
        searchResults = response.predictions
            .map((p) => {"description": p.fullText, "placeId": p.placeId})
            .toList();
      });
    } catch (e) {
      print("Autocomplete Error: $e");

      setState(() {
        searchResults = [
          {"description": "An error occurred while searching."},
        ];
      });
    }
  }

  //fetch  location
  Future<void> selectPlace(String placeId) async {
    try {
      final response = await places.fetchPlace(
        placeId,
        fields: [PlaceField.Location],
      );

      final lat = response.place!.latLng!.lat;
      final lng = response.place!.latLng!.lng;

      final cubit = context.read<GatheringCubit>();
      cubit.updateTempLocation(lat, lng);

      mapController?.animateCamera(
        gmap.CameraUpdate.newLatLng(gmap.LatLng(lat, lng)),
      );

      setState(() {
        searchResults = [];
        searchController.clear();
      });
    } catch (e) {
      print("FetchPlace Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<GatheringCubit>();

    final target = gmap.LatLng(
      cubit.selectedLat ?? defaultLocation.latitude,
      cubit.selectedLng ?? defaultLocation.longitude,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Activity Location"),
        actions: [
          TextButton(
            onPressed: cubit.selectedLat != null
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
                fontWeight: FontWeight.bold,
                color: cubit.selectedLat != null ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          //map
          gmap.GoogleMap(
            initialCameraPosition: gmap.CameraPosition(
              target: target,
              zoom: 13,
            ),
            onMapCreated: (controller) => mapController = controller,
            onTap: (point) {
              cubit.updateTempLocation(point.latitude, point.longitude);
              setState(() {});
            },
            markers: cubit.selectedLat != null
                ? {
                    gmap.Marker(
                      markerId: const gmap.MarkerId("selected"),
                      position: gmap.LatLng(
                        cubit.selectedLat!,
                        cubit.selectedLng!,
                      ),
                    ),
                  }
                : {},
          ),

          //search
          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 6),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: searchPlaces,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search for a place...",
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),

          //search result
          if (searchResults.isNotEmpty)
            Positioned(
              top: 70,
              left: 15,
              right: 15,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 260,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final item = searchResults[index];
                      return ListTile(
                        title: Text(item["description"]),
                        leading: const Icon(Icons.location_on),
                        onTap: () {
                          selectPlace(item["placeId"]);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
