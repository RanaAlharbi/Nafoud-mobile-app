// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'gathering_model.dart';

class GatheringModelMapper extends ClassMapperBase<GatheringModel> {
  GatheringModelMapper._();

  static GatheringModelMapper? _instance;
  static GatheringModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GatheringModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GatheringModel';

  static String? _$id(GatheringModel v) => v.id;
  static const Field<GatheringModel, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String _$userId(GatheringModel v) => v.userId;
  static const Field<GatheringModel, String> _f$userId = Field(
    'userId',
    _$userId,
    key: r'user_id',
  );
  static String _$title(GatheringModel v) => v.title;
  static const Field<GatheringModel, String> _f$title = Field('title', _$title);
  static String _$description(GatheringModel v) => v.description;
  static const Field<GatheringModel, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$city(GatheringModel v) => v.city;
  static const Field<GatheringModel, String> _f$city = Field('city', _$city);
  static String _$date(GatheringModel v) => v.date;
  static const Field<GatheringModel, String> _f$date = Field('date', _$date);
  static String _$eventTime(GatheringModel v) => v.eventTime;
  static const Field<GatheringModel, String> _f$eventTime = Field(
    'eventTime',
    _$eventTime,
    key: r'event_time',
  );
  static String _$address(GatheringModel v) => v.address;
  static const Field<GatheringModel, String> _f$address = Field(
    'address',
    _$address,
  );
  static String _$imageUrl(GatheringModel v) => v.imageUrl;
  static const Field<GatheringModel, String> _f$imageUrl = Field(
    'imageUrl',
    _$imageUrl,
    key: r'image_url',
  );
  static String _$category(GatheringModel v) => v.category;
  static const Field<GatheringModel, String> _f$category = Field(
    'category',
    _$category,
  );
  static double? _$latitude(GatheringModel v) => v.latitude;
  static const Field<GatheringModel, double> _f$latitude = Field(
    'latitude',
    _$latitude,
    opt: true,
  );
  static double? _$longitude(GatheringModel v) => v.longitude;
  static const Field<GatheringModel, double> _f$longitude = Field(
    'longitude',
    _$longitude,
    opt: true,
  );

  @override
  final MappableFields<GatheringModel> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #title: _f$title,
    #description: _f$description,
    #city: _f$city,
    #date: _f$date,
    #eventTime: _f$eventTime,
    #address: _f$address,
    #imageUrl: _f$imageUrl,
    #category: _f$category,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
  };

  static GatheringModel _instantiate(DecodingData data) {
    return GatheringModel(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      city: data.dec(_f$city),
      date: data.dec(_f$date),
      eventTime: data.dec(_f$eventTime),
      address: data.dec(_f$address),
      imageUrl: data.dec(_f$imageUrl),
      category: data.dec(_f$category),
      latitude: data.dec(_f$latitude),
      longitude: data.dec(_f$longitude),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GatheringModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GatheringModel>(map);
  }

  static GatheringModel fromJson(String json) {
    return ensureInitialized().decodeJson<GatheringModel>(json);
  }
}

mixin GatheringModelMappable {
  String toJson() {
    return GatheringModelMapper.ensureInitialized().encodeJson<GatheringModel>(
      this as GatheringModel,
    );
  }

  Map<String, dynamic> toMap() {
    return GatheringModelMapper.ensureInitialized().encodeMap<GatheringModel>(
      this as GatheringModel,
    );
  }

  GatheringModelCopyWith<GatheringModel, GatheringModel, GatheringModel>
  get copyWith => _GatheringModelCopyWithImpl<GatheringModel, GatheringModel>(
    this as GatheringModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return GatheringModelMapper.ensureInitialized().stringifyValue(
      this as GatheringModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return GatheringModelMapper.ensureInitialized().equalsValue(
      this as GatheringModel,
      other,
    );
  }

  @override
  int get hashCode {
    return GatheringModelMapper.ensureInitialized().hashValue(
      this as GatheringModel,
    );
  }
}

extension GatheringModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GatheringModel, $Out> {
  GatheringModelCopyWith<$R, GatheringModel, $Out> get $asGatheringModel =>
      $base.as((v, t, t2) => _GatheringModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GatheringModelCopyWith<$R, $In extends GatheringModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? city,
    String? date,
    String? eventTime,
    String? address,
    String? imageUrl,
    String? category,
    double? latitude,
    double? longitude,
  });
  GatheringModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GatheringModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GatheringModel, $Out>
    implements GatheringModelCopyWith<$R, GatheringModel, $Out> {
  _GatheringModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GatheringModel> $mapper =
      GatheringModelMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    String? userId,
    String? title,
    String? description,
    String? city,
    String? date,
    String? eventTime,
    String? address,
    String? imageUrl,
    String? category,
    Object? latitude = $none,
    Object? longitude = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (userId != null) #userId: userId,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (city != null) #city: city,
      if (date != null) #date: date,
      if (eventTime != null) #eventTime: eventTime,
      if (address != null) #address: address,
      if (imageUrl != null) #imageUrl: imageUrl,
      if (category != null) #category: category,
      if (latitude != $none) #latitude: latitude,
      if (longitude != $none) #longitude: longitude,
    }),
  );
  @override
  GatheringModel $make(CopyWithData data) => GatheringModel(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    city: data.get(#city, or: $value.city),
    date: data.get(#date, or: $value.date),
    eventTime: data.get(#eventTime, or: $value.eventTime),
    address: data.get(#address, or: $value.address),
    imageUrl: data.get(#imageUrl, or: $value.imageUrl),
    category: data.get(#category, or: $value.category),
    latitude: data.get(#latitude, or: $value.latitude),
    longitude: data.get(#longitude, or: $value.longitude),
  );

  @override
  GatheringModelCopyWith<$R2, GatheringModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GatheringModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

