import 'package:equatable/equatable.dart';

// Domain entity representing an Event
// Contains all the core business data for an event
class EventEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? location;
  final String date;
  final String? category;
  final double? latitude;
  final double? longitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const EventEntity({
    required this.id,
    required this.title,
    this.description,
    this.location,
    required this.date,
    this.category,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        location,
        date,
        category,
        latitude,
        longitude,
        createdAt,
        updatedAt,
      ];
}
