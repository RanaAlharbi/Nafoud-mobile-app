import 'package:dart_mappable/dart_mappable.dart';
import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';

part 'events_model.mapper.dart';

@MappableClass()
class EventModel extends EventEntity with EventModelMappable {

 const EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.location,
    required super.date,
  });
}
