import 'package:dart_mappable/dart_mappable.dart';
import '../../domain_layer/entity/currency_exchange_entity.dart';

part 'currency_exchange_model.mapper.dart';

@MappableClass()
class CurrencyExchangeModel extends CurrencyExchangeEntity with CurrencyExchangeModelMappable {
  const CurrencyExchangeModel({
    required super.result,
    @MappableField(key: 'time_last_update_unix') required super.timeLastUpdateUnix,
    @MappableField(key: 'time_last_update_utc') required super.timeLastUpdateUtc,
    @MappableField(key: 'time_next_update_unix') required super.timeNextUpdateUnix,
    @MappableField(key: 'time_next_update_utc') required super.timeNextUpdateUtc,
    @MappableField(key: 'base_code') required super.baseCode,
    @MappableField(key: 'conversion_rates') required super.conversionRates,
  });
}
