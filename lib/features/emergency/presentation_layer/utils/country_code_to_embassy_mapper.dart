/// Maps country codes to embassy names as they appear in emergency_number.json
class CountryCodeToEmbassyMapper {
  static const Map<String, String> _countryCodeToEmbassy = {
    // Americas
    'us': 'United States',
    'ca': 'Canada',
    'mx': 'Mexico',
    'br': 'Brazil',
    'ar': 'Argentina',

    // Europe
    'gb': 'United Kingdom',
    'de': 'Germany',
    'fr': 'France',
    'it': 'Italy',
    'es': 'Spain',
    'nl': 'Netherlands',
    'ch': 'Switzerland',
    'se': 'Sweden',
    'no': 'Norway',
    'dk': 'Denmark',
    'be': 'Belgium',
    'at': 'Austria',
    'gr': 'Greece',
    'pl': 'Poland',
    'ru': 'Russia',

    // Asia
    'cn': 'China',
    'jp': 'Japan',
    'in': 'India',
    'pk': 'Pakistan',
    'id': 'Indonesia',
    'ph': 'Philippines',
    'bd': 'Bangladesh',
    'my': 'Malaysia',
    'kr': 'South Korea',
    'th': 'Thailand',
    'vn': 'Vietnam',
    'sg': 'Singapore',
    'af': 'Afghanistan',
    'lk': 'Sri Lanka',
    'np': 'Nepal',

    // Middle East
    'tr': 'Turkey',
    'eg': 'Egypt',
    'jo': 'Jordan',
    'lb': 'Lebanon',
    'iq': 'Iraq',
    'ir': 'Iran',
    'kw': 'Kuwait',
    'ae': 'UAE',
    'bh': 'Bahrain',
    'om': 'Oman',
    'qa': 'Qatar',
    'ye': 'Yemen',
    'sy': 'Syria',
    'ps': 'Palestine',

    // Africa
    'za': 'South Africa',
    'ng': 'Nigeria',
    'ke': 'Kenya',
    'ma': 'Morocco',
    'tn': 'Tunisia',
    'sd': 'Sudan',
    'dz': 'Algeria',
    'ly': 'Libya',
    'km': 'Comoros',
    'dj': 'Djibouti',
    'so': 'Somalia',
    'mr': 'Mauritania',

    // Oceania
    'au': 'Australia',
    'nz': 'New Zealand',
  };

  /// Convert country code to embassy name
  /// Returns null if no matching embassy is found
  static String? getEmbassyName(String? countryCode) {
    if (countryCode == null) return null;
    return _countryCodeToEmbassy[countryCode.toLowerCase()];
  }

  /// Check if embassy exists for given country code
  static bool hasEmbassy(String? countryCode) {
    if (countryCode == null) return false;
    return _countryCodeToEmbassy.containsKey(countryCode.toLowerCase());
  }
}
