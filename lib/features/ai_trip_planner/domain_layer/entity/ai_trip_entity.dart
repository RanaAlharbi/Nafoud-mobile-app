import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// In the chip options before getting the trip suggestions  
enum TravelerType { solo, partner, family, friends }
enum BudgetTier { flexible, budget, sensible, upscale, luxury }

class TripEntity extends Equatable {
  final String? destination;
  final TravelerType? travelerType;
  final DateTimeRange? dateRange;
  final int? adults;
  final int? kids;
  final List<String> assistanceNeeded;
  final BudgetTier? budget;
  final List<String> interests;

  const TripEntity({
    this.destination,
    this.travelerType,
    this.dateRange,
    this.adults,
    this.kids,
    this.assistanceNeeded = const [], // Accommodation, Activities, Food
    this.budget,
    this.interests = const [],
  });

  TripEntity copy({
    String? destination,
    TravelerType? travelerType,
    DateTimeRange? dateRange,
    int? adults,
    int? kids,
    List<String>? assistanceNeeded,
    BudgetTier? budget,
    List<String>? interests,
  }) {
    return TripEntity(
      destination: destination ?? this.destination,
      travelerType: travelerType ?? this.travelerType,
      dateRange: dateRange ?? this.dateRange,
      adults: adults ?? this.adults,
      kids: kids ?? this.kids,
      assistanceNeeded: assistanceNeeded ?? this.assistanceNeeded,
      budget: budget ?? this.budget,
      interests: interests ?? this.interests,
    );
  }

  @override
  List<Object?> get props => [
    destination,
    travelerType,
    dateRange,
    adults,
    kids,
    assistanceNeeded,
    budget,
    interests,
  ];
}
