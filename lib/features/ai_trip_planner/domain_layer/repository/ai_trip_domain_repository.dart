import 'package:final_project/features/ai_trip_planner/domain_layer/entity/ai_trip_entity.dart';

abstract class TripDomainRepository {
  Future<String> generateTripPlan(TripEntity preferences);
}
