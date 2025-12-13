import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:final_project/features/emergency/data_layer/model/emergency_contact_model.dart';

abstract class EmergencyDataSource {
  Future<List<EmergencyContactModel>> getEmergencyContacts();
  Future<Map<String, String>> getEmbassies();
  Future<Map<String, String>> getDescriptions();
}

class EmergencyDataSourceImpl implements EmergencyDataSource {
  @override
  Future<List<EmergencyContactModel>> getEmergencyContacts() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/jsons/emergency_number.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final List<EmergencyContactModel> contacts = [];

      jsonData.forEach((key, value) {
        contacts.add(EmergencyContactModel.fromJson(key, value));
      });

      return contacts;
    } catch (e) {
      throw Exception('Failed to load emergency contacts: $e');
    }
  }

  @override
  Future<Map<String, String>> getEmbassies() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/jsons/emergency_number.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      if (jsonData['Embassies'] is Map) {
        return Map<String, String>.from(jsonData['Embassies']);
      }

      return {};
    } catch (e) {
      throw Exception('Failed to load embassies: $e');
    }
  }

  @override
  Future<Map<String, String>> getDescriptions() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/jsons/emergency_descriptions.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return Map<String, String>.from(jsonData);
    } catch (e) {
      throw Exception('Failed to load descriptions: $e');
    }
  }
}
