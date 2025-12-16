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
    if (category == null) return 'Unknown';

    switch (category.toLowerCase().trim()) {
      case 'shopping':
        return 'Shopping';
      case 'sport':
      case 'sports':
        return 'Sport';
      case 'concerts':
      case 'concert':
        return 'Concerts';
      case 'food':
      case 'food & drinks':
      case 'food and drinks':
      case 'food & drink':
      case 'dining':
        return 'Food';
      case 'cultural & arts':
      case 'cultural and arts':
      case 'cultural':
      case 'arts':
        return 'Cultural & Arts';
      default:
        return 'Unknown';
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
      'Shopping',
      'Sport',
      'Concerts',
      'Food',
      'Cultural & Arts',
    ];
  }

  // Method to check if a category is valid
  static bool isValidCategory(String? category) {
    if (category == null) return false;
    return getAllCategories()
        .any((cat) => cat.toLowerCase() == category.toLowerCase());
  }
}
