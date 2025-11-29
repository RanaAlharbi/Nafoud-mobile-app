
import 'package:dart_mappable/dart_mappable.dart';
import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';

part 'events_model.mapper.dart';
@MappableClass()
class EventsModel extends EventEntity with EventsModelMappable {
  const EventsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.location,
    super.imageUrl,
    required super.date,
  });
}