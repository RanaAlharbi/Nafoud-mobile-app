import 'package:final_project/features/location/domain/entity/location_entity.dart';

class LocationState {
  final List<LocationEntity> results;
  final double? lat;
  final double? lng;
  final bool loading;

  const LocationState({
    this.results = const [],
    this.lat,
    this.lng,
    this.loading = false,
  });

  LocationState copyWith({
    List<LocationEntity>? results,
    double? lat,
    double? lng,
    bool? loading,
  }) {
    return LocationState(
      results: results ?? this.results,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      loading: loading ?? this.loading,
    );
  }
}


