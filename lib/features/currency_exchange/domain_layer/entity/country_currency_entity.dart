import 'package:equatable/equatable.dart';

class CountryCurrencyEntity extends Equatable {
  final String name;
  final String code;
  final String currencyCode;
  final String currencyName;

  const CountryCurrencyEntity({
    required this.name,
    required this.code,
    required this.currencyCode,
    required this.currencyName,
  });

  factory CountryCurrencyEntity.fromJson(Map<String, dynamic> json) {
    return CountryCurrencyEntity(
      name: json['name'] as String,
      code: json['code'] as String,
      currencyCode: _getCurrencyCode(json['code'] as String),
      currencyName: _getCurrencyName(json['code'] as String),
    );
  }

  static String _getCurrencyCode(String countryCode) {
    final Map<String, String> countryCurrencyMap = {
      'us': 'USD', 'ae': 'AED', 'af': 'AFN', 'al': 'ALL', 'am': 'AMD',
      'ao': 'AOA', 'ar': 'ARS', 'au': 'AUD', 'az': 'AZN', 'ba': 'BAM',
      'bd': 'BDT', 'bg': 'BGN', 'bh': 'BHD', 'bi': 'BIF', 'bn': 'BND',
      'bo': 'BOB', 'br': 'BRL', 'bw': 'BWP', 'by': 'BYN', 'bz': 'BZD',
      'ca': 'CAD', 'cd': 'CDF', 'ch': 'CHF', 'cl': 'CLP', 'cn': 'CNY',
      'co': 'COP', 'cr': 'CRC', 'cu': 'CUP', 'cz': 'CZK', 'dk': 'DKK',
      'do': 'DOP', 'dz': 'DZD', 'eg': 'EGP', 'er': 'ERN', 'et': 'ETB',
      'gb': 'GBP', 'ge': 'GEL', 'gh': 'GHS', 'gn': 'GNF', 'gt': 'GTQ',
      'hk': 'HKD', 'hn': 'HNL', 'hr': 'HRK', 'hu': 'HUF', 'id': 'IDR',
      'il': 'ILS', 'in': 'INR', 'iq': 'IQD', 'ir': 'IRR', 'is': 'ISK',
      'jm': 'JMD', 'jo': 'JOD', 'jp': 'JPY', 'ke': 'KES', 'kg': 'KGS',
      'kh': 'KHR', 'kp': 'KPW', 'kr': 'KRW', 'kw': 'KWD', 'kz': 'KZT',
      'la': 'LAK', 'lb': 'LBP', 'lk': 'LKR', 'lr': 'LRD', 'ly': 'LYD',
      'ma': 'MAD', 'md': 'MDL', 'mg': 'MGA', 'mk': 'MKD', 'mm': 'MMK',
      'mn': 'MNT', 'mu': 'MUR', 'mv': 'MVR', 'mw': 'MWK', 'mx': 'MXN',
      'my': 'MYR', 'mz': 'MZN', 'na': 'NAD', 'ng': 'NGN', 'ni': 'NIO',
      'no': 'NOK', 'np': 'NPR', 'nz': 'NZD', 'om': 'OMR', 'pa': 'PAB',
      'pe': 'PEN', 'pg': 'PGK', 'ph': 'PHP', 'pk': 'PKR', 'pl': 'PLN',
      'py': 'PYG', 'qa': 'QAR', 'ro': 'RON', 'rs': 'RSD', 'ru': 'RUB',
      'rw': 'RWF', 'sa': 'SAR', 'sd': 'SDG', 'se': 'SEK', 'sg': 'SGD',
      'so': 'SOS', 'sy': 'SYP', 'th': 'THB', 'tn': 'TND', 'tr': 'TRY',
      'tw': 'TWD', 'tz': 'TZS', 'ua': 'UAH', 'ug': 'UGX', 'uy': 'UYU',
      'uz': 'UZS', 've': 'VES', 'vn': 'VND', 'ye': 'YER', 'za': 'ZAR',
      'zm': 'ZMW', 'zw': 'ZWL',
    };
    return countryCurrencyMap[countryCode.toLowerCase()] ?? 'USD';
  }

  static String _getCurrencyName(String countryCode) {
    final Map<String, String> currencyNameMap = {
      'us': 'US Dollar', 'ae': 'UAE Dirham', 'af': 'Afghan Afghani',
      'al': 'Albanian Lek', 'am': 'Armenian Dram', 'ao': 'Angolan Kwanza',
      'ar': 'Argentine Peso', 'au': 'Australian Dollar', 'az': 'Azerbaijani Manat',
      'ba': 'Bosnia-Herzegovina Convertible Mark', 'bd': 'Bangladeshi Taka',
      'bg': 'Bulgarian Lev', 'bh': 'Bahraini Dinar', 'bi': 'Burundian Franc',
      'bn': 'Brunei Dollar', 'bo': 'Bolivian Boliviano', 'br': 'Brazilian Real',
      'bw': 'Botswanan Pula', 'by': 'Belarusian Ruble', 'bz': 'Belize Dollar',
      'ca': 'Canadian Dollar', 'cd': 'Congolese Franc', 'ch': 'Swiss Franc',
      'cl': 'Chilean Peso', 'cn': 'Chinese Yuan', 'co': 'Colombian Peso',
      'cr': 'Costa Rican Colón', 'cu': 'Cuban Peso', 'cz': 'Czech Koruna',
      'dk': 'Danish Krone', 'do': 'Dominican Peso', 'dz': 'Algerian Dinar',
      'eg': 'Egyptian Pound', 'er': 'Eritrean Nakfa', 'et': 'Ethiopian Birr',
      'gb': 'British Pound', 'ge': 'Georgian Lari', 'gh': 'Ghanaian Cedi',
      'gn': 'Guinean Franc', 'gt': 'Guatemalan Quetzal', 'hk': 'Hong Kong Dollar',
      'hn': 'Honduran Lempira', 'hr': 'Croatian Kuna', 'hu': 'Hungarian Forint',
      'id': 'Indonesian Rupiah', 'il': 'Israeli New Shekel', 'in': 'Indian Rupee',
      'iq': 'Iraqi Dinar', 'ir': 'Iranian Rial', 'is': 'Icelandic Króna',
      'jm': 'Jamaican Dollar', 'jo': 'Jordanian Dinar', 'jp': 'Japanese Yen',
      'ke': 'Kenyan Shilling', 'kg': 'Kyrgyzstani Som', 'kh': 'Cambodian Riel',
      'kp': 'North Korean Won', 'kr': 'South Korean Won', 'kw': 'Kuwaiti Dinar',
      'kz': 'Kazakhstani Tenge', 'la': 'Laotian Kip', 'lb': 'Lebanese Pound',
      'lk': 'Sri Lankan Rupee', 'lr': 'Liberian Dollar', 'ly': 'Libyan Dinar',
      'ma': 'Moroccan Dirham', 'md': 'Moldovan Leu', 'mg': 'Malagasy Ariary',
      'mk': 'Macedonian Denar', 'mm': 'Myanmar Kyat', 'mn': 'Mongolian Tugrik',
      'mu': 'Mauritian Rupee', 'mv': 'Maldivian Rufiyaa', 'mw': 'Malawian Kwacha',
      'mx': 'Mexican Peso', 'my': 'Malaysian Ringgit', 'mz': 'Mozambican Metical',
      'na': 'Namibian Dollar', 'ng': 'Nigerian Naira', 'ni': 'Nicaraguan Córdoba',
      'no': 'Norwegian Krone', 'np': 'Nepalese Rupee', 'nz': 'New Zealand Dollar',
      'om': 'Omani Rial', 'pa': 'Panamanian Balboa', 'pe': 'Peruvian Sol',
      'pg': 'Papua New Guinean Kina', 'ph': 'Philippine Peso', 'pk': 'Pakistani Rupee',
      'pl': 'Polish Zloty', 'py': 'Paraguayan Guarani', 'qa': 'Qatari Riyal',
      'ro': 'Romanian Leu', 'rs': 'Serbian Dinar', 'ru': 'Russian Ruble',
      'rw': 'Rwandan Franc', 'sa': 'Saudi Riyal', 'sd': 'Sudanese Pound',
      'se': 'Swedish Krona', 'sg': 'Singapore Dollar', 'so': 'Somali Shilling',
      'sy': 'Syrian Pound', 'th': 'Thai Baht', 'tn': 'Tunisian Dinar',
      'tr': 'Turkish Lira', 'tw': 'Taiwan Dollar', 'tz': 'Tanzanian Shilling',
      'ua': 'Ukrainian Hryvnia', 'ug': 'Ugandan Shilling', 'uy': 'Uruguayan Peso',
      'uz': 'Uzbekistani Som', 've': 'Venezuelan Bolívar', 'vn': 'Vietnamese Dong',
      'ye': 'Yemeni Rial', 'za': 'South African Rand', 'zm': 'Zambian Kwacha',
      'zw': 'Zimbabwean Dollar',
    };
    return currencyNameMap[countryCode.toLowerCase()] ?? 'US Dollar';
  }

  @override
  List<Object?> get props => [name, code, currencyCode, currencyName];
}
