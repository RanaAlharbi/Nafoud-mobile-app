import 'package:final_project/features/gathering/domain_layer/entity/gathering_entity.dart';

abstract class GatheringDomainRepository {
  Future<List<GatheringEntity>> getUsersEvents(); //get all ads from supabase
  Future<void> createUserEvent(GatheringEntity gathering); // create gathering ads
  Future<void> deleteUserEvent(String id, String userId ); //to delete user ads
}