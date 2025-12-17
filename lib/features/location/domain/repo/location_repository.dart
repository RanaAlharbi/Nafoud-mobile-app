
import 'package:final_project/features/location/domain/entity/location_entity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class LocationRepository {
  Future<Result<List<LocationEntity>, String>> searchPlaces({
    required String query,
    List<String> countries,
  });

  Future<Result<(double lat, double lng), String>> fetchPlaceLatLng({
    required String placeId,
  });
}
