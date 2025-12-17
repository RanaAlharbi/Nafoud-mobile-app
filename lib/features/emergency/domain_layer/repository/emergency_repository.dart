import 'package:final_project/features/emergency/domain_layer/entity/emergency_contact_entity.dart';

abstract class EmergencyRepository {
  Future<List<EmergencyContactEntity>> getEmergencyContacts(String languageCode);
  Future<Map<String, String>> getEmbassies(String languageCode);
  Future<Map<String, String>> getDescriptions(String languageCode);
}
