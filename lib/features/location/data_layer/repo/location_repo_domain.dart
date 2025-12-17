
import 'package:final_project/features/location/data_layer/datasource/location_datasorce.dart';
import 'package:final_project/features/location/domain/entity/location_entity.dart';
import 'package:final_project/features/location/domain/repo/location_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final BaseLocationRemoteDataSource remote;

  LocationRepositoryImpl(this.remote);

  @override
  Future<Result<List<LocationEntity>, String>> searchPlaces({
    required String query,
    List<String> countries = const ["SA"],
  }) async {
    try {
      final result = await remote.searchPlaces(query, countries);
      return Success(result);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<(double lat, double lng), String>> fetchPlaceLatLng({
    required String placeId,
  }) async {
    try {
      final coords = await remote.fetchLatLng(placeId);
      return Success(coords);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
