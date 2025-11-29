import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final String? imageUrl;

  const EventEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, description, location, date, imageUrl];
}
