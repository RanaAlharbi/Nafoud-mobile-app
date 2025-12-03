import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? location;
  final String date;
  final String? imageUrl;
  final String? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const EventEntity({
    required this.id,
    required this.title,
    this.description,
    this.location,
    required this.date,
    this.imageUrl,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id,title,description,location,date,imageUrl,category,createdAt,updatedAt];
  
}
