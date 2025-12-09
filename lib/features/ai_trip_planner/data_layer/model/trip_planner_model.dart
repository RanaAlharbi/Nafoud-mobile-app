import 'package:dart_mappable/dart_mappable.dart';
import 'package:final_project/features/ai_trip_planner/domain_layer/entity/ai_trip_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'trip_planner_model.mapper.dart';

@MappableClass()
class TripModel extends TripEntity with TripModelMappable {
  const TripModel({
    String? destination,
    TravelerType? travelerType,
    int? adults,
    int? kids,
    DateTimeRange? dateRange,
    List<String>? assistanceNeeded,
    BudgetTier? budget,
    List<String>? interests,
  }) : super(
         destination: destination,
         travelerType: travelerType,
         adults: adults,
         kids: kids,
         dateRange: dateRange,
         assistanceNeeded: assistanceNeeded ?? const [],
         budget: budget,
         interests: interests ?? const [],
       );

  factory TripModel.fromEntity(TripEntity entity) {
    return TripModel(
      destination: entity.destination,
      travelerType: entity.travelerType,
      adults: entity.adults,
      kids: entity.kids,
      dateRange: entity.dateRange,
      assistanceNeeded: entity.assistanceNeeded,
      budget: entity.budget,
      interests: entity.interests,
    );
  }

  String toAiPrompt() {
    final dateStr = dateRange != null
        ? "${DateFormat('MMM dd').format(dateRange!.start)} to ${DateFormat('MMM dd').format(dateRange!.end)}"
        : "Dates not decided";

    final travelerStr = travelerType?.name ?? "Not Specified";
    final budgetStr = budget?.name ?? "Flexible";

    final interestsStr = interests.isEmpty
        ? "General sightseeing"
        : interests.join(", ");

    return """
    Act as 'Murshid', a personalized Saudi Arabia trip planner. 
    Based on the provided Context, generate a detailed day-by-day itinerary for a trip to ${destination ?? 'Saudi Arabia'}.
    
    Context:
    - Travelers: ${adults ?? 1} Adults, ${kids ?? 0} Kids ($travelerStr)
    - Dates: $dateStr
    - Budget: $budgetStr
    - Interests: $interestsStr
    - Needs help with: ${assistanceNeeded.join(', ')}

    Output Format:
    1. Start ONLY with the welcome phrase: "Ok, This is Your Personalized Saudi Arabia Trip Plan 🇸🇦".
    2. Immediately follow the welcome phrase with the itinerary. DO NOT add any extra introductory text, summaries, or general tips.
    3. Format each day using bold headers, bullet points, and relevant emojis.
    4. Separate each day's plan with a horizontal line consisting of three dashes: "---".

    Example Day Formatting (you can choose the relevat emojis to the recommendations):
    
    **Day 1 📍 – Arrival & Local Exploration**
    * 🏨 Check-in at a family-friendly, budget hotel.
    * 🕌 Explore Al Masmak Fort, a cultural and historical landmark.
    * 🍽️ Dinner at a local restaurant, enjoying traditional Saudi flavors.
    
    ---
    
    **Day 2 🐫 – Adventure & Nature**
    * 🌞 Morning desert safari – camel rides and dune adventures.
    * 💧 Afternoon stroll at Wadi Hanifah, a beautiful natural oasis.
    * ☕ Evening coffee at a popular local café.
    
    ---
    
    **Day 3 🏛️ – Culture & Museums**
    * 🖼️ Visit the National Museum of Saudi Arabia for an immersive cultural experience.
    * 🛍️ Evening shopping at Riyadh Gallery Mall.
    
    (Continue this exact format until the end of the trip).
    """;
  }
}
