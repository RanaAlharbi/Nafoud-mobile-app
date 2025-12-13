import 'package:equatable/equatable.dart';
import 'package:final_project/features/emergency/domain_layer/entity/emergency_contact_entity.dart';

abstract class EmergencyState extends Equatable {
  const EmergencyState();

  @override
  List<Object?> get props => [];
}

class EmergencyInitialState extends EmergencyState {
  const EmergencyInitialState();
}

class EmergencyLoadingState extends EmergencyState {
  const EmergencyLoadingState();
}

class EmergencyLoadedState extends EmergencyState {
  final List<EmergencyContactEntity> contacts;
  final List<EmergencyContactEntity> filteredContacts;
  final Map<String, String> embassies;
  final Map<String, String> descriptions;
  final Map<String, String> iconMap;
  final String? selectedEmbassy;

  const EmergencyLoadedState({
    required this.contacts,
    required this.filteredContacts,
    required this.embassies,
    required this.descriptions,
    required this.iconMap,
    this.selectedEmbassy,
  });

  @override
  List<Object?> get props => [
        contacts,
        filteredContacts,
        embassies,
        descriptions,
        iconMap,
        selectedEmbassy,
      ];

  EmergencyLoadedState copyWith({
    List<EmergencyContactEntity>? contacts,
    List<EmergencyContactEntity>? filteredContacts,
    Map<String, String>? embassies,
    Map<String, String>? descriptions,
    Map<String, String>? iconMap,
    String? selectedEmbassy,
  }) {
    return EmergencyLoadedState(
      contacts: contacts ?? this.contacts,
      filteredContacts: filteredContacts ?? this.filteredContacts,
      embassies: embassies ?? this.embassies,
      descriptions: descriptions ?? this.descriptions,
      iconMap: iconMap ?? this.iconMap,
      selectedEmbassy: selectedEmbassy ?? this.selectedEmbassy,
    );
  }
}

class EmergencyErrorState extends EmergencyState {
  final String message;

  const EmergencyErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
