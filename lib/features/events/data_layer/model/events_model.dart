import 'package:dart_mappable/dart_mappable.dart';
import 'package:final_project/features/events/domain_layer/entity/events_entity.dart';

part 'events_model.mapper.dart';

// Data model for Event
// Extends [EventEntity] and provides mapping functionality
@MappableClass()
class EventModel extends EventEntity with EventModelMappable {
  const EventModel({
    required super.id,
    required super.title,
    super.description,
    super.location,
    required super.date,
    super.imageUrl,
    super.category,
    super.createdAt,
    super.updatedAt,
  });
}
