// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'events_model.dart';

class EventsModelMapper extends ClassMapperBase<EventsModel> {
  EventsModelMapper._();

  static EventsModelMapper? _instance;
  static EventsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventsModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventsModel';

  static String _$id(EventsModel v) => v.id;
  static const Field<EventsModel, String> _f$id = Field('id', _$id);
  static String _$title(EventsModel v) => v.title;
  static const Field<EventsModel, String> _f$title = Field('title', _$title);
  static String _$description(EventsModel v) => v.description;
  static const Field<EventsModel, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$location(EventsModel v) => v.location;
  static const Field<EventsModel, String> _f$location = Field(
    'location',
    _$location,
  );
  static String? _$imageUrl(EventsModel v) => v.imageUrl;
  static const Field<EventsModel, String> _f$imageUrl = Field(
    'imageUrl',
    _$imageUrl,
    opt: true,
  );
  static DateTime _$date(EventsModel v) => v.date;
  static const Field<EventsModel, DateTime> _f$date = Field('date', _$date);

  @override
  final MappableFields<EventsModel> fields = const {
    #id: _f$id,
    #title: _f$title,
    #description: _f$description,
    #location: _f$location,
    #imageUrl: _f$imageUrl,
    #date: _f$date,
  };

  static EventsModel _instantiate(DecodingData data) {
    return EventsModel(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      location: data.dec(_f$location),
      imageUrl: data.dec(_f$imageUrl),
      date: data.dec(_f$date),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static EventsModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventsModel>(map);
  }

  static EventsModel fromJson(String json) {
    return ensureInitialized().decodeJson<EventsModel>(json);
  }
}

mixin EventsModelMappable {
  String toJson() {
    return EventsModelMapper.ensureInitialized().encodeJson<EventsModel>(
      this as EventsModel,
    );
  }

  Map<String, dynamic> toMap() {
    return EventsModelMapper.ensureInitialized().encodeMap<EventsModel>(
      this as EventsModel,
    );
  }

  EventsModelCopyWith<EventsModel, EventsModel, EventsModel> get copyWith =>
      _EventsModelCopyWithImpl<EventsModel, EventsModel>(
        this as EventsModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EventsModelMapper.ensureInitialized().stringifyValue(
      this as EventsModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return EventsModelMapper.ensureInitialized().equalsValue(
      this as EventsModel,
      other,
    );
  }

  @override
  int get hashCode {
    return EventsModelMapper.ensureInitialized().hashValue(this as EventsModel);
  }
}

extension EventsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventsModel, $Out> {
  EventsModelCopyWith<$R, EventsModel, $Out> get $asEventsModel =>
      $base.as((v, t, t2) => _EventsModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EventsModelCopyWith<$R, $In extends EventsModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? title,
    String? description,
    String? location,
    String? imageUrl,
    DateTime? date,
  });
  EventsModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventsModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventsModel, $Out>
    implements EventsModelCopyWith<$R, EventsModel, $Out> {
  _EventsModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventsModel> $mapper =
      EventsModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? title,
    String? description,
    String? location,
    Object? imageUrl = $none,
    DateTime? date,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (location != null) #location: location,
      if (imageUrl != $none) #imageUrl: imageUrl,
      if (date != null) #date: date,
    }),
  );
  @override
  EventsModel $make(CopyWithData data) => EventsModel(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    location: data.get(#location, or: $value.location),
    imageUrl: data.get(#imageUrl, or: $value.imageUrl),
    date: data.get(#date, or: $value.date),
  );

  @override
  EventsModelCopyWith<$R2, EventsModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EventsModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

