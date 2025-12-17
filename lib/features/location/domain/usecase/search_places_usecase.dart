import 'package:final_project/features/location/domain/entity/location_entity.dart';
import 'package:final_project/features/location/domain/repo/location_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@injectable
class SearchPlacesUseCase {
  final LocationRepository repo;

  SearchPlacesUseCase(this.repo);

  Future<Result<List<LocationEntity>, String>> call({
    required String query,
    List<String> countries = const ["SA"],
  }) async {
   if (query.trim().isEmpty) {
      return const Success<List<LocationEntity>, String>([]);
    }

    return repo.searchPlaces(query: query, countries: countries);
  }
}