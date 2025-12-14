import 'package:equatable/equatable.dart';

class GatheringEntity extends Equatable {
  final String id; //to delete the event through id 
  final String userId;
  final String title;
  final String description;
  final String city;
  final String date;
  final String address;
  final String imageUrl;
  final String category;

  const GatheringEntity(
    this.id,
    this.userId,
    this.title,
    this.description,
    this.city,
    this.date,
    this.address,
    this.imageUrl,
    this.category,
  );

  @override
  List<Object?> get props => [id, userId, title, description, city, date, address, imageUrl, category];
}
