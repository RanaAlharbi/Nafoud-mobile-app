

import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class BookmarkDomainRepository {
  Future<Result<List<String>, String>> getBookmarks();
  Future<Result<bool, String>> add(String eventId);
  Future<Result<bool, String>> remove(String eventId);
  Future<Result<List<GatheringEntity>, String>> getEventsByIds(List<String> ids);

}