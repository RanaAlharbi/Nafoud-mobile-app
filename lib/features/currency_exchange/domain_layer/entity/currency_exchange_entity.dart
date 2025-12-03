import 'package:equatable/equatable.dart';

class CurrencyExchangeEntity extends Equatable {
  final String result;
  final int timeLastUpdateUnix;
  final String timeLastUpdateUtc;
  final int timeNextUpdateUnix;
  final String timeNextUpdateUtc;
  final String baseCode;
  final Map<String, double> conversionRates;

  const CurrencyExchangeEntity({
    required this.result,
    required this.timeLastUpdateUnix,
    required this.timeLastUpdateUtc,
    required this.timeNextUpdateUnix,
    required this.timeNextUpdateUtc,
    required this.baseCode,
    required this.conversionRates,
  });

  @override
  List<Object?> get props => [
        result,
        timeLastUpdateUnix,
        timeLastUpdateUtc,
        timeNextUpdateUnix,
        timeNextUpdateUtc,
        baseCode,
        conversionRates,
      ];
}
