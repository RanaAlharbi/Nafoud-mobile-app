import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import '../model/currency_exchange_model.dart';

abstract class CurrencyCacheDatasource {
  Future<CurrencyExchangeModel?> getCachedRates(String baseCurrency);
  Future<void> cacheRates(CurrencyExchangeModel rates);
  Future<bool> isCacheValid(String baseCurrency, String currentUpdateTime);
  Future<void> clearCache();
}

@LazySingleton(as: CurrencyCacheDatasource)
class GetStorageCurrencyCacheDatasource implements CurrencyCacheDatasource {
  final GetStorage storage;
  static const String cacheKey = 'currency_exchange_rates';

  GetStorageCurrencyCacheDatasource(this.storage);

  @override
  Future<CurrencyExchangeModel?> getCachedRates(String baseCurrency) async {
    // We will only support SAR as base currency (cuz the app is about Saudi Arabia)
    if (baseCurrency.toUpperCase() != 'SAR') {
      return null;
    }

    try {
      // Read cached data from GetStorage
      final cachedData = storage.read(cacheKey);

      if (cachedData == null) return null;

      // Parse the cached data
      final data = cachedData as Map<String, dynamic>;

      // Rebuild "conversion_rates" by inverting all the SAR rates
      final conversionRates = <String, double>{};
      final rates = data['rates'] as Map<String, dynamic>;

      for (final entry in rates.entries) {
        final currencyCode = entry.key;
        final currencyToSarRate = (entry.value as num).toDouble();

        // Skip invalid cached rates (incase if we got an error)
        if (!currencyToSarRate.isFinite || currencyToSarRate == 0) continue;

        // Invert back: if 1 USD = 3.75 SAR, then 1 SAR = 1/3.75 = 0.27 USD
        final sarToCurrencyRate = 1 / currencyToSarRate;

        // Skip if inverted rate is invalid (incase if we got an error)
        if (!sarToCurrencyRate.isFinite || sarToCurrencyRate == 0) continue;

        conversionRates[currencyCode] = sarToCurrencyRate;
      }

      // Rebuild the model in SAR format for the app to use
      return CurrencyExchangeModel(
        result: data['result'] as String,
        timeLastUpdateUnix: data['time_last_update_unix'] as int,
        timeLastUpdateUtc: data['time_last_update_utc'] as String,
        timeNextUpdateUnix: data['time_next_update_unix'] as int,
        timeNextUpdateUtc: data['time_next_update_utc'] as String,
        baseCode: 'SAR',
        conversionRates: conversionRates,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheRates(CurrencyExchangeModel rates) async {
    try {
      // Extract all currencies and invert rates for storage
      final conversionRates = rates.conversionRates;
      final Map<String, double> invertedRates = {};

      for (final entry in conversionRates.entries) {
        final currencyCode = entry.key;
        final sarToCurrencyRate = entry.value;

        // Skip SAR to SAR conversion
        if (currencyCode.toUpperCase() == 'SAR') continue;

        // Skip invalid rates (infinity, NaN, or 0) = (incase of an error)
        if (!sarToCurrencyRate.isFinite || sarToCurrencyRate == 0) continue;

        // Invert the rate: if 1 SAR = 0.2667 USD, then 1 USD = 3.7496 SAR
        final currencyToSarRate = 1 / sarToCurrencyRate;

        // Skip if inverted rate is invalid
        if (!currencyToSarRate.isFinite || currencyToSarRate == 0) continue;

        // Store the numbers specifically (0.6 will be 0.6 not 1)
        invertedRates[currencyCode] = currencyToSarRate;
      }

      // Store all data in a single structure
      final cacheData = {
        'result': rates.result,
        'time_last_update_unix': rates.timeLastUpdateUnix,
        'time_last_update_utc': rates.timeLastUpdateUtc,
        'time_next_update_unix': rates.timeNextUpdateUnix,
        'time_next_update_utc': rates.timeNextUpdateUtc,
        'rates': invertedRates,
      };

      // Save to GetStorage
      await storage.write(cacheKey, cacheData);
    } catch (e) {
      throw Exception('Failed to cache rates: $e');
    }
  }

  @override
  Future<bool> isCacheValid(
    String baseCurrency,
    String currentUpdateTime,
  ) async {
    try {
      final cached = await getCachedRates(baseCurrency);

      if (cached == null) return false;

      return cached.timeLastUpdateUtc == currentUpdateTime;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearCache() async {
    await storage.remove(cacheKey);
  }
}
