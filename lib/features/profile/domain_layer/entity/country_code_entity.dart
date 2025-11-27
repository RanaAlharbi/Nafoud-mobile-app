class CountryCodeEntity {
  final String name;
  final String code;
  final String dialCode;

  const CountryCodeEntity({
    required this.name,
    required this.code,
    required this.dialCode,
  });

  factory CountryCodeEntity.fromJson(Map<String, dynamic> json) {
    return CountryCodeEntity(
      name: json['name'] as String,
      code: json['code'] as String,
      dialCode: json['dialCode'] as String,
    );
  }

  String get flagUrl => 'https://flagcdn.com/w20/$code.png';
}
