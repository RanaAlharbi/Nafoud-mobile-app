import 'package:final_project/features/emergency/domain_layer/entity/emergency_contact_entity.dart';

class EmergencyContactModel extends EmergencyContactEntity {
  EmergencyContactModel({
    required super.name,
    required super.number,
    super.icon,
    super.description,
    super.isEmbassy,
    super.embassies,
  });

  factory EmergencyContactModel.fromJson(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      // This is the embassies object
      return EmergencyContactModel(
        name: key,
        number: '', // Will be set when embassy is selected
        isEmbassy: true,
        embassies: Map<String, String>.from(value),
      );
    } else {
      // Regular emergency contact
      return EmergencyContactModel(
        name: key,
        number: value.toString(),
        isEmbassy: false,
      );
    }
  }

  EmergencyContactEntity toEntity() {
    return EmergencyContactEntity(
      name: name,
      number: number,
      icon: icon,
      description: description,
      isEmbassy: isEmbassy,
      embassies: embassies,
    );
  }
}
