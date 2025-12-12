import 'package:equatable/equatable.dart';

class GatheringEntity extends Equatable {
  final String? id;
  final String userId;
  final String title;
  final String description;
  final String city;
  final String date;
  final String eventTime;
  final String address;
  final String imageUrl;
  final String category;
  final double? latitude;
  final double? longitude;
  final bool isBookmarked;
  

  const GatheringEntity({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.city,
    required this.date,
    required this.eventTime,
    required this.address,
    required this.imageUrl,
    required this.category,
    this.latitude,
    this.longitude,
    this.isBookmarked = false,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    title,
    description,
    city,
    date,
    eventTime,
    address,
    imageUrl,
    category,
    latitude,
    longitude,
  ];
}
