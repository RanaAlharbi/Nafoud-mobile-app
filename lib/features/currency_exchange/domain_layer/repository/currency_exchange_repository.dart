import 'package:dartz/dartz.dart';
import '../entity/currency_exchange_entity.dart';

abstract class CurrencyExchangeRepository {
  Future<Either<String, CurrencyExchangeEntity>> getExchangeRates(String baseCurrency);
}
