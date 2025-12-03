// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'currency_exchange_model.dart';

class CurrencyExchangeModelMapper
    extends ClassMapperBase<CurrencyExchangeModel> {
  CurrencyExchangeModelMapper._();

  static CurrencyExchangeModelMapper? _instance;
  static CurrencyExchangeModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CurrencyExchangeModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CurrencyExchangeModel';

  static String _$result(CurrencyExchangeModel v) => v.result;
  static const Field<CurrencyExchangeModel, String> _f$result = Field(
    'result',
    _$result,
  );
  static int _$timeLastUpdateUnix(CurrencyExchangeModel v) =>
      v.timeLastUpdateUnix;
  static const Field<CurrencyExchangeModel, int> _f$timeLastUpdateUnix = Field(
    'timeLastUpdateUnix',
    _$timeLastUpdateUnix,
    key: r'time_last_update_unix',
  );
  static String _$timeLastUpdateUtc(CurrencyExchangeModel v) =>
      v.timeLastUpdateUtc;
  static const Field<CurrencyExchangeModel, String> _f$timeLastUpdateUtc =
      Field(
        'timeLastUpdateUtc',
        _$timeLastUpdateUtc,
        key: r'time_last_update_utc',
      );
  static int _$timeNextUpdateUnix(CurrencyExchangeModel v) =>
      v.timeNextUpdateUnix;
  static const Field<CurrencyExchangeModel, int> _f$timeNextUpdateUnix = Field(
    'timeNextUpdateUnix',
    _$timeNextUpdateUnix,
    key: r'time_next_update_unix',
  );
  static String _$timeNextUpdateUtc(CurrencyExchangeModel v) =>
      v.timeNextUpdateUtc;
  static const Field<CurrencyExchangeModel, String> _f$timeNextUpdateUtc =
      Field(
        'timeNextUpdateUtc',
        _$timeNextUpdateUtc,
        key: r'time_next_update_utc',
      );
  static String _$baseCode(CurrencyExchangeModel v) => v.baseCode;
  static const Field<CurrencyExchangeModel, String> _f$baseCode = Field(
    'baseCode',
    _$baseCode,
    key: r'base_code',
  );
  static Map<String, double> _$conversionRates(CurrencyExchangeModel v) =>
      v.conversionRates;
  static const Field<CurrencyExchangeModel, Map<String, double>>
  _f$conversionRates = Field(
    'conversionRates',
    _$conversionRates,
    key: r'conversion_rates',
  );

  @override
  final MappableFields<CurrencyExchangeModel> fields = const {
    #result: _f$result,
    #timeLastUpdateUnix: _f$timeLastUpdateUnix,
    #timeLastUpdateUtc: _f$timeLastUpdateUtc,
    #timeNextUpdateUnix: _f$timeNextUpdateUnix,
    #timeNextUpdateUtc: _f$timeNextUpdateUtc,
    #baseCode: _f$baseCode,
    #conversionRates: _f$conversionRates,
  };

  static CurrencyExchangeModel _instantiate(DecodingData data) {
    return CurrencyExchangeModel(
      result: data.dec(_f$result),
      timeLastUpdateUnix: data.dec(_f$timeLastUpdateUnix),
      timeLastUpdateUtc: data.dec(_f$timeLastUpdateUtc),
      timeNextUpdateUnix: data.dec(_f$timeNextUpdateUnix),
      timeNextUpdateUtc: data.dec(_f$timeNextUpdateUtc),
      baseCode: data.dec(_f$baseCode),
      conversionRates: data.dec(_f$conversionRates),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CurrencyExchangeModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CurrencyExchangeModel>(map);
  }

  static CurrencyExchangeModel fromJson(String json) {
    return ensureInitialized().decodeJson<CurrencyExchangeModel>(json);
  }
}

mixin CurrencyExchangeModelMappable {
  String toJson() {
    return CurrencyExchangeModelMapper.ensureInitialized()
        .encodeJson<CurrencyExchangeModel>(this as CurrencyExchangeModel);
  }

  Map<String, dynamic> toMap() {
    return CurrencyExchangeModelMapper.ensureInitialized()
        .encodeMap<CurrencyExchangeModel>(this as CurrencyExchangeModel);
  }

  CurrencyExchangeModelCopyWith<
    CurrencyExchangeModel,
    CurrencyExchangeModel,
    CurrencyExchangeModel
  >
  get copyWith =>
      _CurrencyExchangeModelCopyWithImpl<
        CurrencyExchangeModel,
        CurrencyExchangeModel
      >(this as CurrencyExchangeModel, $identity, $identity);
  @override
  String toString() {
    return CurrencyExchangeModelMapper.ensureInitialized().stringifyValue(
      this as CurrencyExchangeModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return CurrencyExchangeModelMapper.ensureInitialized().equalsValue(
      this as CurrencyExchangeModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CurrencyExchangeModelMapper.ensureInitialized().hashValue(
      this as CurrencyExchangeModel,
    );
  }
}

extension CurrencyExchangeModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CurrencyExchangeModel, $Out> {
  CurrencyExchangeModelCopyWith<$R, CurrencyExchangeModel, $Out>
  get $asCurrencyExchangeModel => $base.as(
    (v, t, t2) => _CurrencyExchangeModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CurrencyExchangeModelCopyWith<
  $R,
  $In extends CurrencyExchangeModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, double, ObjectCopyWith<$R, double, double>>
  get conversionRates;
  $R call({
    String? result,
    int? timeLastUpdateUnix,
    String? timeLastUpdateUtc,
    int? timeNextUpdateUnix,
    String? timeNextUpdateUtc,
    String? baseCode,
    Map<String, double>? conversionRates,
  });
  CurrencyExchangeModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CurrencyExchangeModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CurrencyExchangeModel, $Out>
    implements CurrencyExchangeModelCopyWith<$R, CurrencyExchangeModel, $Out> {
  _CurrencyExchangeModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CurrencyExchangeModel> $mapper =
      CurrencyExchangeModelMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, double, ObjectCopyWith<$R, double, double>>
  get conversionRates => MapCopyWith(
    $value.conversionRates,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(conversionRates: v),
  );
  @override
  $R call({
    String? result,
    int? timeLastUpdateUnix,
    String? timeLastUpdateUtc,
    int? timeNextUpdateUnix,
    String? timeNextUpdateUtc,
    String? baseCode,
    Map<String, double>? conversionRates,
  }) => $apply(
    FieldCopyWithData({
      if (result != null) #result: result,
      if (timeLastUpdateUnix != null) #timeLastUpdateUnix: timeLastUpdateUnix,
      if (timeLastUpdateUtc != null) #timeLastUpdateUtc: timeLastUpdateUtc,
      if (timeNextUpdateUnix != null) #timeNextUpdateUnix: timeNextUpdateUnix,
      if (timeNextUpdateUtc != null) #timeNextUpdateUtc: timeNextUpdateUtc,
      if (baseCode != null) #baseCode: baseCode,
      if (conversionRates != null) #conversionRates: conversionRates,
    }),
  );
  @override
  CurrencyExchangeModel $make(CopyWithData data) => CurrencyExchangeModel(
    result: data.get(#result, or: $value.result),
    timeLastUpdateUnix: data.get(
      #timeLastUpdateUnix,
      or: $value.timeLastUpdateUnix,
    ),
    timeLastUpdateUtc: data.get(
      #timeLastUpdateUtc,
      or: $value.timeLastUpdateUtc,
    ),
    timeNextUpdateUnix: data.get(
      #timeNextUpdateUnix,
      or: $value.timeNextUpdateUnix,
    ),
    timeNextUpdateUtc: data.get(
      #timeNextUpdateUtc,
      or: $value.timeNextUpdateUtc,
    ),
    baseCode: data.get(#baseCode, or: $value.baseCode),
    conversionRates: data.get(#conversionRates, or: $value.conversionRates),
  );

  @override
  CurrencyExchangeModelCopyWith<$R2, CurrencyExchangeModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CurrencyExchangeModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

