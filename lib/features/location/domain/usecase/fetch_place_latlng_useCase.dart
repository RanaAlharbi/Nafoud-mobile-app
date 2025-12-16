import 'package:final_project/features/location/domain/repo/location_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@injectable
class FetchPlaceLatLngUseCase {
  final LocationRepository repo;

  FetchPlaceLatLngUseCase(this.repo);

  Future<Result<(double lat, double lng), String>> call({
    required String placeId,
  }) {
    return repo.fetchPlaceLatLng(placeId: placeId);
  }
}

