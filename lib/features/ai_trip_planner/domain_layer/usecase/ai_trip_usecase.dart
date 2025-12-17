import 'package:final_project/features/ai_trip_planner/domain_layer/entity/ai_trip_entity.dart';
import 'package:final_project/features/ai_trip_planner/domain_layer/repository/ai_trip_domain_repository.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GenerateTripUseCase {
  final TripDomainRepository repository;

  GenerateTripUseCase(this.repository);

  // Function is "Call" because there's only one function.. it can be named anything
  Future<LlmProvider> call(TripEntity preferences) {
    return repository.generateTripPlan(preferences);
  }
}
