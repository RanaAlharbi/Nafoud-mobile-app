part of 'currency_exchange_cubit.dart';

class CurrencyExchangeState extends Equatable {
  final List<CountryCurrencyEntity>? currencies;
  final String fromCurrency;
  final String? toCurrency;
  final String amount;
  final double? convertedAmount;
  final String? errorMessage;
  final bool isLoading;

  const CurrencyExchangeState({
    this.currencies,
    this.fromCurrency = 'SAR',
    this.toCurrency,
    this.amount = '0',
    this.convertedAmount,
    this.errorMessage,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        currencies,
        fromCurrency,
        toCurrency,
        amount,
        convertedAmount,
        errorMessage,
        isLoading,
      ];

  CurrencyExchangeState copyWith({
    List<CountryCurrencyEntity>? currencies,
    String? fromCurrency,
    String? toCurrency,
    String? amount,
    double? convertedAmount,
    String? errorMessage,
    bool? isLoading,
  }) {
    return CurrencyExchangeState(
      currencies: currencies ?? this.currencies,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      amount: amount ?? this.amount,
      convertedAmount: convertedAmount ?? this.convertedAmount,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
