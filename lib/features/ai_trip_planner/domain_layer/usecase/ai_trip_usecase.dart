import 'package:final_project/features/ai_trip_planner/domain_layer/entity/ai_trip_entity.dart';
import 'package:final_project/features/ai_trip_planner/domain_layer/repository/ai_trip_domain_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GenerateTripUseCase {
  final TripDomainRepository repository;

  GenerateTripUseCase(this.repository);

  Future<String> call(TripEntity preferences) {
    return repository.generateTripPlan(preferences);
  }
}
