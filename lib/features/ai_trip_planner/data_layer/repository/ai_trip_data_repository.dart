import 'package:final_project/features/ai_trip_planner/data_layer/data_source/ai_trip_datasource.dart';
import 'package:final_project/features/ai_trip_planner/data_layer/model/trip_planner_model.dart';
import 'package:final_project/features/ai_trip_planner/domain_layer/entity/ai_trip_entity.dart';
import 'package:final_project/features/ai_trip_planner/domain_layer/repository/ai_trip_domain_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

@LazySingleton(as: TripDomainRepository)
class TripDataRepository implements TripDomainRepository {
  final TripDataSource _dataSource;

  TripDataRepository(this._dataSource);

  @override
  Future<String> generateTripPlan(TripEntity preferences) async {
    final model = TripModel.fromEntity(preferences);
    final systemPrompt = model.toAiPrompt();

    try {
      final llmProvider = await _dataSource.initializeChatWithPrompt(
        systemPrompt,
      );

      final initialResponse = llmProvider.history
          .lastWhere((msg) => msg.origin == MessageOrigin.llm)
          .text;

      return initialResponse ?? "Failed to generate plan text.";
    } catch (e) {
      throw Exception("Failed to generate trip plan: $e");
    }
  }
}
