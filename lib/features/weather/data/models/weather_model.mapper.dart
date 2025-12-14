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

  static double _$lon(WeatherModel v) => v.lon;
  static const Field<WeatherModel, double> _f$lon = Field('lon', _$lon);
  static double _$lat(WeatherModel v) => v.lat;
  static const Field<WeatherModel, double> _f$lat = Field('lat', _$lat);
  static int _$weatherId(WeatherModel v) => v.weatherId;
  static const Field<WeatherModel, int> _f$weatherId = Field(
    'weatherId',
    _$weatherId,
  );
  static String _$weatherMain(WeatherModel v) => v.weatherMain;
  static const Field<WeatherModel, String> _f$weatherMain = Field(
    'weatherMain',
    _$weatherMain,
  );
  static String _$weatherDescription(WeatherModel v) => v.weatherDescription;
  static const Field<WeatherModel, String> _f$weatherDescription = Field(
    'weatherDescription',
    _$weatherDescription,
  );
  static String _$weatherIcon(WeatherModel v) => v.weatherIcon;
  static const Field<WeatherModel, String> _f$weatherIcon = Field(
    'weatherIcon',
    _$weatherIcon,
  );
  static double _$temp(WeatherModel v) => v.temp;
  static const Field<WeatherModel, double> _f$temp = Field('temp', _$temp);
  static double _$feelsLike(WeatherModel v) => v.feelsLike;
  static const Field<WeatherModel, double> _f$feelsLike = Field(
    'feelsLike',
    _$feelsLike,
  );
  static double _$tempMin(WeatherModel v) => v.tempMin;
  static const Field<WeatherModel, double> _f$tempMin = Field(
    'tempMin',
    _$tempMin,
  );
  static double _$tempMax(WeatherModel v) => v.tempMax;
  static const Field<WeatherModel, double> _f$tempMax = Field(
    'tempMax',
    _$tempMax,
  );
  static DateTime _$savedAt(WeatherModel v) => v.savedAt;
  static const Field<WeatherModel, DateTime> _f$savedAt = Field(
    'savedAt',
    _$savedAt,
  );

  @override
  final MappableFields<WeatherModel> fields = const {
    #lon: _f$lon,
    #lat: _f$lat,
    #weatherId: _f$weatherId,
    #weatherMain: _f$weatherMain,
    #weatherDescription: _f$weatherDescription,
    #weatherIcon: _f$weatherIcon,
    #temp: _f$temp,
    #feelsLike: _f$feelsLike,
    #tempMin: _f$tempMin,
    #tempMax: _f$tempMax,
    #savedAt: _f$savedAt,
  };

  static WeatherModel _instantiate(DecodingData data) {
    return WeatherModel(
      lon: data.dec(_f$lon),
      lat: data.dec(_f$lat),
      weatherId: data.dec(_f$weatherId),
      weatherMain: data.dec(_f$weatherMain),
      weatherDescription: data.dec(_f$weatherDescription),
      weatherIcon: data.dec(_f$weatherIcon),
      temp: data.dec(_f$temp),
      feelsLike: data.dec(_f$feelsLike),
      tempMin: data.dec(_f$tempMin),
      tempMax: data.dec(_f$tempMax),
      savedAt: data.dec(_f$savedAt),
    );
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
  $R call({
    double? lon,
    double? lat,
    int? weatherId,
    String? weatherMain,
    String? weatherDescription,
    String? weatherIcon,
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    DateTime? savedAt,
  });
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
  $R call({
    double? lon,
    double? lat,
    int? weatherId,
    String? weatherMain,
    String? weatherDescription,
    String? weatherIcon,
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    DateTime? savedAt,
  }) => $apply(
    FieldCopyWithData({
      if (lon != null) #lon: lon,
      if (lat != null) #lat: lat,
      if (weatherId != null) #weatherId: weatherId,
      if (weatherMain != null) #weatherMain: weatherMain,
      if (weatherDescription != null) #weatherDescription: weatherDescription,
      if (weatherIcon != null) #weatherIcon: weatherIcon,
      if (temp != null) #temp: temp,
      if (feelsLike != null) #feelsLike: feelsLike,
      if (tempMin != null) #tempMin: tempMin,
      if (tempMax != null) #tempMax: tempMax,
      if (savedAt != null) #savedAt: savedAt,
    }),
  );
  @override
  WeatherModel $make(CopyWithData data) => WeatherModel(
    lon: data.get(#lon, or: $value.lon),
    lat: data.get(#lat, or: $value.lat),
    weatherId: data.get(#weatherId, or: $value.weatherId),
    weatherMain: data.get(#weatherMain, or: $value.weatherMain),
    weatherDescription: data.get(
      #weatherDescription,
      or: $value.weatherDescription,
    ),
    weatherIcon: data.get(#weatherIcon, or: $value.weatherIcon),
    temp: data.get(#temp, or: $value.temp),
    feelsLike: data.get(#feelsLike, or: $value.feelsLike),
    tempMin: data.get(#tempMin, or: $value.tempMin),
    tempMax: data.get(#tempMax, or: $value.tempMax),
    savedAt: data.get(#savedAt, or: $value.savedAt),
  );

  @override
  WeatherModelCopyWith<$R2, WeatherModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WeatherModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

