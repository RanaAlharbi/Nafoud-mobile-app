import 'package:final_project/core/routes/router.dart';

class QuickGuideItemsWidget {
  static final List<Map<String, dynamic>> quickGuides = [
    {
      'svgPath': './assets/icons/Tram.svg',
      'label': 'Transport',
      'route': AppRoutes.transportScreen,
    },
    {
      'svgPath': './assets/icons/SimCard.svg',
      'label': 'SIM Card',
      'route': AppRoutes.simCardScreen,
    },
    {
      'svgPath': './assets/icons/Emergency.svg',
      'label': 'Emergency',
      'route': AppRoutes.emergencyScreen,
    },
    {
      'svgPath': './assets/icons/Cloud.svg',
      'label': 'Weather',
      'route': AppRoutes.weatherScreen,
    },
    {
      'svgPath': './assets/icons/Currency.svg',
      'label': 'Currency',
      'route': AppRoutes.currencyScreen,
    },
  ];
}
