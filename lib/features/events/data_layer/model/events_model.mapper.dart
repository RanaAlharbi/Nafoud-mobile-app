// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'events_model.dart';

class EventModelMapper extends ClassMapperBase<EventModel> {
  EventModelMapper._();

  static EventModelMapper? _instance;
  static EventModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventModel';

  static String _$id(EventModel v) => v.id;
  static const Field<EventModel, String> _f$id = Field('id', _$id);
  static String _$title(EventModel v) => v.title;
  static const Field<EventModel, String> _f$title = Field('title', _$title);
  static String? _$description(EventModel v) => v.description;
  static const Field<EventModel, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static String? _$location(EventModel v) => v.location;
  static const Field<EventModel, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
  );
  static String _$date(EventModel v) => v.date;
  static const Field<EventModel, String> _f$date = Field('date', _$date);
  static String? _$category(EventModel v) => v.category;
  static const Field<EventModel, String> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );
  static double? _$latitude(EventModel v) => v.latitude;
  static const Field<EventModel, double> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
  );
  static double? _$longitude(EventModel v) => v.longitude;
  static const Field<EventModel, double> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
  );
  static DateTime? _$createdAt(EventModel v) => v.createdAt;
  static const Field<EventModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static DateTime? _$updatedAt(EventModel v) => v.updatedAt;
  static const Field<EventModel, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );

  @override
  final MappableFields<EventModel> fields = const {
    #id: _f$id,
    #title: _f$title,
    #description: _f$description,
    #location: _f$location,
    #date: _f$date,
    #category: _f$category,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static EventModel _instantiate(DecodingData data) {
    return EventModel(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      location: data.dec(_f$location),
      date: data.dec(_f$date),
      category: data.dec(_f$category),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EventModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventModel>(map);
  }

  static EventModel fromJson(String json) {
    return ensureInitialized().decodeJson<EventModel>(json);
  }
}

mixin EventModelMappable {
  String toJson() {
    return EventModelMapper.ensureInitialized().encodeJson<EventModel>(
      this as EventModel,
    );
  }

  Map<String, dynamic> toMap() {
    return EventModelMapper.ensureInitialized().encodeMap<EventModel>(
      this as EventModel,
    );
  }

  EventModelCopyWith<EventModel, EventModel, EventModel> get copyWith =>
      _EventModelCopyWithImpl<EventModel, EventModel>(
        this as EventModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EventModelMapper.ensureInitialized().stringifyValue(
      this as EventModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return EventModelMapper.ensureInitialized().equalsValue(
      this as EventModel,
      other,
    );
  }

  @override
  int get hashCode {
    return EventModelMapper.ensureInitialized().hashValue(this as EventModel);
  }
}

extension EventModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventModel, $Out> {
  EventModelCopyWith<$R, EventModel, $Out> get $asEventModel =>
      $base.as((v, t, t2) => _EventModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EventModelCopyWith<$R, $In extends EventModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? title,
    String? description,
    String? location,
    String? date,
    String? category,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  EventModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventModel, $Out>
    implements EventModelCopyWith<$R, EventModel, $Out> {
  _EventModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventModel> $mapper =
      EventModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? title,
    Object? description = $none,
    Object? location = $none,
    String? date,
    Object? category = $none,
    Object? latitude = $none,
    Object? longitude = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (description != $none) #description: description,
      if (location != $none) #location: location,
      if (date != null) #date: date,
      if (category != $none) #category: category,
      if (latitude != $none) #latitude: latitude,
      if (longitude != $none) #longitude: longitude,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
    }),
  );
  @override
  EventModel $make(CopyWithData data) => EventModel(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    location: data.get(#location, or: $value.location),
    date: data.get(#date, or: $value.date),
    category: data.get(#category, or: $value.category),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  EventModelCopyWith<$R2, EventModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EventModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

