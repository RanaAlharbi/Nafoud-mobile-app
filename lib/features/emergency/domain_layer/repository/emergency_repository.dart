import 'package:final_project/features/emergency/domain_layer/entity/emergency_contact_entity.dart';

abstract class EmergencyRepository {
  Future<List<EmergencyContactEntity>> getEmergencyContacts();
  Future<Map<String, String>> getEmbassies();
  Future<Map<String, String>> getDescriptions();
}
