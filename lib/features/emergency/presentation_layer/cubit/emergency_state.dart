import 'package:final_project/features/emergency/domain_layer/entity/emergency_contact_entity.dart';

abstract class EmergencyState {}

class EmergencyInitialState extends EmergencyState {}

class EmergencyLoadingState extends EmergencyState {}

class EmergencyLoadedState extends EmergencyState {
  final List<EmergencyContactEntity> contacts;
  final List<EmergencyContactEntity> filteredContacts;
  final Map<String, String> embassies;
  final Map<String, String> descriptions;
  final String? selectedEmbassy;

  EmergencyLoadedState({
    required this.contacts,
    required this.filteredContacts,
    required this.embassies,
    required this.descriptions,
    this.selectedEmbassy,
  });

  EmergencyLoadedState copyWith({
    List<EmergencyContactEntity>? contacts,
    List<EmergencyContactEntity>? filteredContacts,
    Map<String, String>? embassies,
    Map<String, String>? descriptions,
    String? selectedEmbassy,
  }) {
    return EmergencyLoadedState(
      contacts: contacts ?? this.contacts,
      filteredContacts: filteredContacts ?? this.filteredContacts,
      embassies: embassies ?? this.embassies,
      descriptions: descriptions ?? this.descriptions,
      selectedEmbassy: selectedEmbassy ?? this.selectedEmbassy,
    );
  }
}

class EmergencyErrorState extends EmergencyState {
  final String message;

  EmergencyErrorState(this.message);
}
