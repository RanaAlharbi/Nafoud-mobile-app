import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String id;

  const WeatherEntity({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
