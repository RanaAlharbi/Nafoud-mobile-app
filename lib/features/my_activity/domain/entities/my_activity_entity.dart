import 'package:equatable/equatable.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';

class MyActivityEntity extends Equatable {
  final List<GatheringEntity> events;

  const MyActivityEntity({
    required this.events,
  });

  @override
  List<Object?> get props => [events];
}
