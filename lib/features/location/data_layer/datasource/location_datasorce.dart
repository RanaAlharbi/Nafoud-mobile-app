
import 'package:final_project/features/location/domain/entity/location_entity.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:injectable/injectable.dart';

abstract class BaseLocationRemoteDataSource {
  Future<List<LocationEntity>> searchPlaces(
    String query,
    List<String> countries,
  );

  Future<(double, double)> fetchLatLng(String placeId);
}


@LazySingleton(as: BaseLocationRemoteDataSource)
class LocationRemoteDataSource implements BaseLocationRemoteDataSource {
  final FlutterGooglePlacesSdk places;

  LocationRemoteDataSource(this.places);

  @override
  Future<List<LocationEntity>> searchPlaces(
    String query,
    List<String> countries,
  ) async {
    final response = await places.findAutocompletePredictions(
      query,
      countries: countries,
    );

    return response.predictions
        .map(
          (p) => LocationEntity(
            description: p.fullText,
            placeId: p.placeId,
          ),
        )
        .toList();
  }

  @override
  Future<(double, double)> fetchLatLng(String placeId) async {
    final response = await places.fetchPlace(
      placeId,
      fields: [PlaceField.Location],
    );

    final latLng = response.place!.latLng!;
    return (latLng.lat, latLng.lng);
  }
}

