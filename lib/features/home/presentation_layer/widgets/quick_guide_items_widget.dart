import 'package:final_project/core/routes/router.dart';

class QuickGuideItemsWidget {
  static final List<Map<String, dynamic>> quickGuides = [
    {
      'svgPath': './assets/icons/Tram.svg',
      'label': 'home.guides.transport',
      'route': AppRoutes.transportScreen,
    },
    {
      'svgPath': './assets/icons/SimCard.svg',
      'label': 'home.guides.sim_card',
      'route': AppRoutes.simCardScreen,
    },
    {
      'svgPath': './assets/icons/Emergency.svg',
      'label': 'home.guides.emergency',
      'route': AppRoutes.emergencyScreen,
    },
    {
      'svgPath': './assets/icons/Cloud.svg',
      'label': 'home.guides.weather',
      'route': AppRoutes.weatherScreen,
    },
    {
      'svgPath': './assets/icons/Currency.svg',
      'label': 'home.guides.currency',
      'route': AppRoutes.currencyScreen,
    },
  ];
}
