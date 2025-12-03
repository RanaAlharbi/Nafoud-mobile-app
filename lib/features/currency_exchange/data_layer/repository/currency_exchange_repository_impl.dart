import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain_layer/entity/currency_exchange_entity.dart';
import '../../domain_layer/repository/currency_exchange_repository.dart';
import '../datasource/currency_exchange_datasource.dart';

@LazySingleton(as: CurrencyExchangeRepository)
class CurrencyExchangeRepositoryImpl implements CurrencyExchangeRepository {
  final CurrencyExchangeDatasource datasource;

  CurrencyExchangeRepositoryImpl(this.datasource);

  @override
  Future<Either<String, CurrencyExchangeEntity>> getExchangeRates(String baseCurrency) async {
    try {
      // Always fetch SAR rates to minimize API calls
      final rates = await datasource.getExchangeRates('SAR');
      return Right(rates);
    } catch (e) {
      return Left('Failed to get exchange rates: ${e.toString()}');
    }
  }
}
