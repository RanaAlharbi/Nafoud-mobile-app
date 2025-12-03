import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data_layer/datasource/currency_cache_datasource.dart';
import '../../domain_layer/entity/country_currency_entity.dart';
import '../../domain_layer/entity/currency_exchange_entity.dart';
import '../../domain_layer/usecase/currency_exchange_usecase.dart';

part 'currency_exchange_state.dart';

@injectable
class CurrencyExchangeCubit extends Cubit<CurrencyExchangeState> {
  final CurrencyExchangeUsecase _usecase;
  final CurrencyCacheDatasource _cacheDatasource;
  CurrencyExchangeEntity? _cachedRates;

  CurrencyExchangeCubit(this._usecase, this._cacheDatasource) : super(CurrencyExchangeState()) {
    loadCurrencies();
    _initializeWithFreshData();
  }

  Future<void> _initializeWithFreshData() async {
    await _cacheDatasource.clearCache();
    await loadExchangeRates();
  }

  Future<void> forceRefresh() async {
    if (isClosed) return;
    await _cacheDatasource.clearCache();
    _cachedRates = null;
    await loadExchangeRates();
    if (state.toCurrency != null) {
      _performConversion();
    }
  }

  Future<void> loadCurrencies() async {
    try {
      final String response = await rootBundle.loadString('Assets/jsons/country_code.json');
      final List<dynamic> data = json.decode(response);

      final allCurrencies = data
          .map((json) => CountryCurrencyEntity.fromJson(json))
          .where((currency) =>
              currency.currencyCode.isNotEmpty &&
              currency.currencyCode != 'Unknown')
          .toList();

      final seenCodes = <String>{};
      final uniqueCurrencies = allCurrencies.where((currency) {
        if (seenCodes.contains(currency.currencyCode)) {
          return false;
        }
        seenCodes.add(currency.currencyCode);
        return true;
      }).toList();

      if (!uniqueCurrencies.any((c) => c.currencyCode == 'SAR')) {
        uniqueCurrencies.insert(0, const CountryCurrencyEntity(
          name: 'Saudi Arabia',
          code: 'sa',
          currencyCode: 'SAR',
          currencyName: 'Saudi Riyal',
        ));
      }

      if (!isClosed) {
        emit(state.copyWith(currencies: uniqueCurrencies));
      }
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(errorMessage: 'Failed to load currencies: $e'));
      }
    }
  }

  Future<void> loadExchangeRates() async {
    if (isClosed) return;

    final ratesResult = await _usecase.getExchangeRates('SAR');
    if (isClosed) return;

    ratesResult.fold(
      (error) {
        if (!isClosed) {
          emit(state.copyWith(errorMessage: error));
        }
      },
      (rates) {
        _cachedRates = rates;
      },
    );
  }

  void changeAmount(String amount) {
    if (isClosed) return;
    emit(state.copyWith(amount: amount));
    if (state.toCurrency != null) {
      _performConversion();
    }
  }

  void changeFromCurrency(String currency) {
    if (isClosed) return;

    String? newToCurrency = state.toCurrency;
    if (currency == 'SAR') {
      if (state.toCurrency == 'SAR') {
        newToCurrency = null;
      }
    } else {
      newToCurrency = 'SAR';
    }

    emit(state.copyWith(
      fromCurrency: currency,
      toCurrency: newToCurrency,
    ));

    if (newToCurrency != null) {
      _performConversion();
    }
  }

  void changeToCurrency(String currency) {
    if (isClosed) return;
    emit(state.copyWith(toCurrency: currency));
    _performConversion();
  }

  void swapCurrencies() {
    if (isClosed || state.toCurrency == null) return;

    emit(state.copyWith(
      fromCurrency: state.toCurrency,
      toCurrency: state.fromCurrency,
    ));

    _performConversion();
  }

  void _performConversion() {
    if (isClosed || state.toCurrency == null) return;

    final amount = double.tryParse(state.amount);
    if (amount == null || amount <= 0) return;

    if (_cachedRates == null) {
      emit(state.copyWith(errorMessage: 'Exchange rates not loaded yet'));
      return;
    }

    double convertedAmount;
    final from = state.fromCurrency.toUpperCase();
    final to = state.toCurrency!.toUpperCase();

    if (from == 'SAR') {
      final sarToTargetRate = _cachedRates?.conversionRates[to];
      if (sarToTargetRate == null) {
        emit(state.copyWith(errorMessage: 'Currency $to not found'));
        return;
      }
      if (!sarToTargetRate.isFinite || sarToTargetRate == 0) {
        emit(state.copyWith(errorMessage: 'Invalid exchange rate for $to'));
        return;
      }
      convertedAmount = amount * sarToTargetRate;
    } else if (to == 'SAR') {
      final sarToFromRate = _cachedRates?.conversionRates[from];
      if (sarToFromRate == null) {
        emit(state.copyWith(errorMessage: 'Currency $from not found'));
        return;
      }
      if (!sarToFromRate.isFinite || sarToFromRate == 0) {
        emit(state.copyWith(errorMessage: 'Invalid exchange rate for $from'));
        return;
      }
      convertedAmount = amount / sarToFromRate;
    } else {
      emit(state.copyWith(errorMessage: 'One currency must be SAR'));
      return;
    }

    if (!convertedAmount.isFinite) {
      emit(state.copyWith(errorMessage: 'Conversion result is invalid'));
      return;
    }

    emit(state.copyWith(
      convertedAmount: convertedAmount,
      errorMessage: null,
    ));
  }
}
