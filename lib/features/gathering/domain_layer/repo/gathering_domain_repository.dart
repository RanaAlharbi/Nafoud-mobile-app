import 'package:final_project/features/gathering/data_layer/model/gathering_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class GatheringDomainRepository {
  Future<Result<List<GatheringModel>, String>> getUsersEvents();
  Future<Result<void, String>> createUserEvent(GatheringModel event);
  Future<Result<void, String>> deleteUserEvent(String id, String userId);
}