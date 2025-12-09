// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'weather_model.dart';

class WeatherModelMapper extends ClassMapperBase<WeatherModel> {
  WeatherModelMapper._();

  static WeatherModelMapper? _instance;
  static WeatherModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WeatherModel';

  static String _$id(WeatherModel v) => v.id;
  static const Field<WeatherModel, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<WeatherModel> fields = const {#id: _f$id};

  static WeatherModel _instantiate(DecodingData data) {
    return WeatherModel(id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static WeatherModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WeatherModel>(map);
  }

  static WeatherModel fromJson(String json) {
    return ensureInitialized().decodeJson<WeatherModel>(json);
  }
}

mixin WeatherModelMappable {
  String toJson() {
    return WeatherModelMapper.ensureInitialized().encodeJson<WeatherModel>(
      this as WeatherModel,
    );
  }

  Map<String, dynamic> toMap() {
    return WeatherModelMapper.ensureInitialized().encodeMap<WeatherModel>(
      this as WeatherModel,
    );
  }

  WeatherModelCopyWith<WeatherModel, WeatherModel, WeatherModel> get copyWith =>
      _WeatherModelCopyWithImpl<WeatherModel, WeatherModel>(
        this as WeatherModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WeatherModelMapper.ensureInitialized().stringifyValue(
      this as WeatherModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return WeatherModelMapper.ensureInitialized().equalsValue(
      this as WeatherModel,
      other,
    );
  }

  @override
  int get hashCode {
    return WeatherModelMapper.ensureInitialized().hashValue(
      this as WeatherModel,
    );
  }
}

extension WeatherModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WeatherModel, $Out> {
  WeatherModelCopyWith<$R, WeatherModel, $Out> get $asWeatherModel =>
      $base.as((v, t, t2) => _WeatherModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WeatherModelCopyWith<$R, $In extends WeatherModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id});
  WeatherModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WeatherModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WeatherModel, $Out>
    implements WeatherModelCopyWith<$R, WeatherModel, $Out> {
  _WeatherModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WeatherModel> $mapper =
      WeatherModelMapper.ensureInitialized();
  @override
  $R call({String? id}) => $apply(FieldCopyWithData({if (id != null) #id: id}));
  @override
  WeatherModel $make(CopyWithData data) =>
      WeatherModel(id: data.get(#id, or: $value.id));

  @override
  WeatherModelCopyWith<$R2, WeatherModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WeatherModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

