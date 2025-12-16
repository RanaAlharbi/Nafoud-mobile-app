import 'package:equatable/equatable.dart';

class MyActivityEntity extends Equatable {
  final String id;

  const MyActivityEntity({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
