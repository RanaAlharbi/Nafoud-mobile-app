// Day/Night cycle based on Saudi Arabia
class WeatherTimeHelper {
  // Saudi Arabia timezone offset from UTC (in hours)
  static const int saudiArabiaUtcOffset = 3;

  // Day starts at 6:00 AM
  static const int dayStartHour = 6;

  // Night starts at 6:00 PM (18:00)
  static const int nightStartHour = 18;

  // Gets the current time in Saudi Arabia timezone
  static DateTime getSaudiArabiaTime() {
    final utcNow = DateTime.now().toUtc();
    return utcNow.add(const Duration(hours: saudiArabiaUtcOffset));
  }

  // Check the current time in Saudi Arabia
  // Day time: 6:00 AM - 6:00 PM (06:00 - 18:00)
  // Night time: 6:00 PM - 6:00 AM (18:00 - 06:00)
  static bool isDayTime() {
    final saudiTime = getSaudiArabiaTime();
    final hour = saudiTime.hour;
    return hour >= dayStartHour && hour < nightStartHour;
  }

  // Adjusts the weather icon code to match the current day/night cycle
  static String adjustIconForTime(String iconCode) {
    if (iconCode.isEmpty) {
      return iconCode;
    }

    // Get the base icon code (without the last character)
    final baseCode = iconCode.substring(0, iconCode.length - 1);

    // Determine the appropriate suffix based on current time
    final suffix = isDayTime() ? 'd' : 'n';

    return '$baseCode$suffix';
  }

  // Gets a human-readable description of the current time
  static String getTimePeriod() {
    return isDayTime() ? 'Day' : 'Night';
  }

  // Formats Saudi Arabia time for display
  static String formatSaudiArabiaTime() {
    final saudiTime = getSaudiArabiaTime();
    return '${saudiTime.hour.toString().padLeft(2, '0')}:${saudiTime.minute.toString().padLeft(2, '0')}';
  }
}
