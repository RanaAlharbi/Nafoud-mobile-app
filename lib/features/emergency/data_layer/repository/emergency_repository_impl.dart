import 'package:final_project/features/emergency/data_layer/datasource/emergency_datasource.dart';
import 'package:final_project/features/emergency/domain_layer/entity/emergency_contact_entity.dart';
import 'package:final_project/features/emergency/domain_layer/repository/emergency_repository.dart';

class EmergencyRepositoryImpl implements EmergencyRepository {
  final EmergencyDataSource dataSource;

  EmergencyRepositoryImpl(this.dataSource);

  @override
  Future<List<EmergencyContactEntity>> getEmergencyContacts() async {
    try {
      final contacts = await dataSource.getEmergencyContacts();
      return contacts.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get emergency contacts: $e');
    }
  }

  @override
  Future<Map<String, String>> getEmbassies() async {
    try {
      return await dataSource.getEmbassies();
    } catch (e) {
      throw Exception('Failed to get embassies: $e');
    }
  }

  @override
  Future<Map<String, String>> getDescriptions() async {
    try {
      return await dataSource.getDescriptions();
    } catch (e) {
      throw Exception('Failed to get descriptions: $e');
    }
  }
}
