import 'package:final_project/features/ai_trip_planner/domain_layer/entity/ai_trip_entity.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';


abstract class TripDomainRepository {
  Future<LlmProvider> generateTripPlan(TripEntity preferences);
}
