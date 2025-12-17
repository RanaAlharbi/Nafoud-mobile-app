import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:final_project/features/emergency/data_layer/model/emergency_contact_model.dart';

abstract class EmergencyDataSource {
  Future<List<EmergencyContactModel>> getEmergencyContacts(String languageCode);
  Future<Map<String, String>> getEmbassies(String languageCode);
  Future<Map<String, String>> getDescriptions(String languageCode);
}

class EmergencyDataSourceImpl implements EmergencyDataSource {
  @override
  Future<List<EmergencyContactModel>> getEmergencyContacts(String languageCode) async {
    try {
      // Load language-specific file based on language code
      final isArabic = languageCode == 'ar';
      final fileName = isArabic ? 'emergency_number_ar.json' : 'emergency_number.json';
      final String jsonString = await rootBundle.loadString('assets/jsons/$fileName');
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
  Future<Map<String, String>> getEmbassies(String languageCode) async {
    try {
      // Load language-specific file based on language code
      final isArabic = languageCode == 'ar';
      final fileName = isArabic ? 'emergency_number_ar.json' : 'emergency_number.json';
      final embassiesKey = isArabic ? 'السفارات' : 'Embassies';
      final String jsonString = await rootBundle.loadString('assets/jsons/$fileName');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      if (jsonData[embassiesKey] is Map) {
        return Map<String, String>.from(jsonData[embassiesKey]);
      }

      return {};
    } catch (e) {
      throw Exception('Failed to load embassies: $e');
    }
  }

  @override
  Future<Map<String, String>> getDescriptions(String languageCode) async {
    try {
      // Load language-specific file based on language code
      final isArabic = languageCode == 'ar';
      final fileName = isArabic ? 'emergency_descriptions_ar.json' : 'emergency_descriptions.json';
      final String jsonString = await rootBundle.loadString('assets/jsons/$fileName');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return Map<String, String>.from(jsonData);
    } catch (e) {
      throw Exception('Failed to load descriptions: $e');
    }
  }
}
