import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entity/currency_exchange_entity.dart';
import '../repository/currency_exchange_repository.dart';

@injectable
class CurrencyExchangeUsecase {
  final CurrencyExchangeRepository _repository;

  CurrencyExchangeUsecase(this._repository);

  Future<Either<String, CurrencyExchangeEntity>> getExchangeRates(String baseCurrency) {
    return _repository.getExchangeRates(baseCurrency);
  }
}
