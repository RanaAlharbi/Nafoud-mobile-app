import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class GatheringDomainRepository {
  Future<Result<List<GatheringEntity>, String>> getUsersEvents();
  Future<Result<void, String>> createUserEvent(GatheringEntity event);
  Future<Result<void, String>> deleteUserEvent(String id, String userId);
  Future<Result<List<GatheringEntity>, String>> searchEvents(String keyword);
  Future<Result<List<GatheringEntity>, String>> getEventsForMap();
  Future<Result<void, String>> addBookmark(String eventId);
  Future<Result<void, String>> removeBookmark(String eventId);
  Future<Result<String, String>> uploadImage(String filePath);

}