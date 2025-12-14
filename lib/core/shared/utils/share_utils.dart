import 'package:share_plus/share_plus.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';

class ShareUtils  {
  static Future<void> shareEvent(GatheringEntity event) async {
    final lat = event.latitude;
    final lng = event.longitude;

    final text =
        """
    📢  ${event.title}

    📅  ${event.date}
    ⏰  ${event.eventTime}
    📍  ${event.city}

    Open in Google Maps:
    https://www.google.com/maps/search/?api=1&query=$lat,$lng
    """;

    await SharePlus.instance.share(ShareParams(text: text));
  }
}
