import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

// Utility class for event category-related operations
// Provides methods to get category images, display names, and colors
class EventCategoryUtils {
  // Private constructor to prevent instantiation
  EventCategoryUtils._();

  // Method to get category image path based on category name
  static String getCategoryImagePath(String? category) {
    if (category == null) return 'assets/Images/events/Empty.svg';

    switch (category.toLowerCase().trim()) {
      case 'shopping':
        return 'assets/Images/events/Shopping.svg';
      case 'sport':
      case 'sports':
        return 'assets/Images/events/Sport.svg';
      case 'concerts':
      case 'concert':
        return 'assets/Images/events/Concerts.svg';
      case 'food':
      case 'food & drinks':
      case 'food and drinks':
      case 'food & drink':
      case 'dining':
        return 'assets/Images/events/Food.svg';
      case 'cultural & arts':
      case 'cultural and arts':
      case 'cultural':
      case 'arts':
        return 'assets/Images/events/CulturalAndArts.svg';
      default:
        return 'assets/Images/events/Empty.svg';
    }
  }

  // Method to get category display name
  static String getCategoryDisplayName(String? category) {
    if (category == null) return 'events.categories.unknown'.tr();

    switch (category.toLowerCase().trim()) {
      case 'shopping':
        return 'events.categories.shopping'.tr();
      case 'sport':
      case 'sports':
        return 'events.categories.sport'.tr();
      case 'concerts':
      case 'concert':
        return 'events.categories.concerts'.tr();
      case 'food':
      case 'food & drinks':
      case 'food and drinks':
      case 'food & drink':
      case 'dining':
        return 'events.categories.food'.tr();
      case 'cultural & arts':
      case 'cultural and arts':
      case 'cultural':
      case 'arts':
        return 'events.categories.culturalAndArts'.tr();
      default:
        return 'events.categories.unknown'.tr();
    }
  }

  // Method to get category color
  static Color getCategoryColor(String? category) {
    if (category == null) return Colors.grey;

    switch (category.toLowerCase().trim()) {
      case 'shopping':
        return const Color(0xFF627BA5);
      case 'sport':
      case 'sports':
        return AppColors.khuzamaColor;
      case 'concerts':
      case 'concert':
        return Colors.black;
      case 'food':
      case 'food & drinks':
      case 'food and drinks':
      case 'food & drink':
      case 'dining':
        return AppColors.primaryColor;
      case 'cultural & arts':
      case 'cultural and arts':
      case 'cultural':
      case 'arts':
        return AppColors.doohbanColor;
      default:
        return Colors.grey;
    }
  }

  // Method to get all available categories
  static List<String> getAllCategories() {
    return [
      'events.categories.shopping'.tr(),
      'events.categories.sport'.tr(),
      'events.categories.concerts'.tr(),
      'events.categories.food'.tr(),
      'events.categories.culturalAndArts'.tr(),
    ];
  }

  // Method to check if a category is valid
  static bool isValidCategory(String? category) {
    if (category == null) return false;
    return getAllCategories()
        .any((cat) => cat.toLowerCase() == category.toLowerCase());
  }

  // Method to get database category key from translated display name
  // This is the reverse of getCategoryDisplayName()
  static String? getCategoryKeyFromTranslation(String? translatedName) {
    if (translatedName == null) return null;

    // Check against all possible translated values
    if (translatedName == 'events.categories.shopping'.tr()) {
      return 'shopping';
    } else if (translatedName == 'events.categories.sport'.tr()) {
      return 'sport';
    } else if (translatedName == 'events.categories.concerts'.tr()) {
      return 'concerts';
    } else if (translatedName == 'events.categories.food'.tr()) {
      return 'food';
    } else if (translatedName == 'events.categories.culturalAndArts'.tr()) {
      return 'cultural & arts';
    } else if (translatedName == 'events.categories.all'.tr()) {
      return 'all';
    }

    return null;
  }
}
