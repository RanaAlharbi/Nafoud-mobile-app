import 'package:url_launcher/url_launcher.dart';

class MapLauncher {

  static Future<void> openGoogleMaps(double lat, double lng) async {
    final url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
  
}
