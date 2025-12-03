import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import '../model/currency_exchange_model.dart';
import 'currency_cache_datasource.dart';

abstract class CurrencyExchangeDatasource {
  Future<CurrencyExchangeModel> getExchangeRates(String baseCurrency);
}

@LazySingleton(as: CurrencyExchangeDatasource)
class CurrencyExchangeDatasourceImpl implements CurrencyExchangeDatasource {
  final Dio dio;
  final CurrencyCacheDatasource cacheDatasource;

  CurrencyExchangeDatasourceImpl(this.dio, this.cacheDatasource);

  @override
  Future<CurrencyExchangeModel> getExchangeRates(String baseCurrency) async {
    try {
      // First, check if we have cached data
      final cachedRates = await cacheDatasource.getCachedRates(baseCurrency);

      if (cachedRates != null) {
        // Verify if cache is still valid by checking with API's latest update time
        final apiKey = dotenv.env['ExchangeRateAPIKey'];
        final baseUrl = dotenv.env['ExchangeRateBaseURL'];

        if (apiKey == null || baseUrl == null) {
          throw Exception('API key or base URL not found');
        }

        // Make API call to check if data has been updated
        final response = await dio.get(
          '$baseUrl/$apiKey/latest/${baseCurrency.toUpperCase()}',
        );

        if (response.statusCode == 200) {
          final apiData = CurrencyExchangeModelMapper.fromMap(response.data);

          // If the last update time matches cached data, return cached data
          if (cachedRates.timeLastUpdateUtc == apiData.timeLastUpdateUtc) {
            return cachedRates;
          }

          // If API data is newer, cache it and return it
          await cacheDatasource.cacheRates(apiData);
          return apiData;
        }
      }

      // No cache or cache check failed, fetch from API
      final apiKey = dotenv.env['ExchangeRateAPIKey'];
      final baseUrl = dotenv.env['ExchangeRateBaseURL'];

      if (apiKey == null || baseUrl == null) {
        throw Exception('API key or base URL not found');
      }

      final response = await dio.get(
        '$baseUrl/$apiKey/latest/${baseCurrency.toUpperCase()}',
      );

      if (response.statusCode == 200) {
        final rates = CurrencyExchangeModelMapper.fromMap(response.data);

        // Cache the fresh data
        await cacheDatasource.cacheRates(rates);

        return rates;
      } else {
        throw Exception('Failed to load exchange rates: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // If network error and we have cached data, return cached data as fallback
      final cachedRates = await cacheDatasource.getCachedRates(baseCurrency);
      if (cachedRates != null) {
        return cachedRates;
      }

      if (e.response != null) {
        throw Exception('API Error: ${e.response?.data['error-type'] ?? e.message}');
      } else {
        throw Exception('Network Error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
