import 'package:equatable/equatable.dart';

class GatheringEntity  extends Equatable {
 
  final String id;
  final String userId;
  final String description;
  final String city;
  final String date;
  final String address;
  final String imageUrl;

  const GatheringEntity(this.id, this.userId, this.description, this.city, this.date, this.address, this.imageUrl);
  
  @override
  List<Object?> get props =>  [id,userId,description,city,date,address,imageUrl];
}