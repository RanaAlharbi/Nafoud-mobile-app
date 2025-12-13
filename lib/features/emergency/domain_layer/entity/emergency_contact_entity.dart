class EmergencyContactEntity {
  final String name;
  final String number;
  final String? icon;
  final String? description;
  final bool isEmbassy;
  final Map<String, String>? embassies;

  EmergencyContactEntity({
    required this.name,
    required this.number,
    this.icon,
    this.description,
    this.isEmbassy = false,
    this.embassies,
  });
}
