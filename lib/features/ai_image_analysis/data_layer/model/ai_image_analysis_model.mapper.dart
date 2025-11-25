// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'ai_image_analysis_model.dart';

class AiImageAnalysisModelMapper extends ClassMapperBase<AiImageAnalysisModel> {
  AiImageAnalysisModelMapper._();

  static AiImageAnalysisModelMapper? _instance;
  static AiImageAnalysisModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AiImageAnalysisModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AiImageAnalysisModel';

  static String _$text(AiImageAnalysisModel v) => v.text;
  static const Field<AiImageAnalysisModel, String> _f$text = Field(
    'text',
    _$text,
  );

  @override
  final MappableFields<AiImageAnalysisModel> fields = const {#text: _f$text};

  static AiImageAnalysisModel _instantiate(DecodingData data) {
    return AiImageAnalysisModel(data.dec(_f$text));
  }

  @override
  final Function instantiate = _instantiate;

  static AiImageAnalysisModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AiImageAnalysisModel>(map);
  }

  static AiImageAnalysisModel fromJson(String json) {
    return ensureInitialized().decodeJson<AiImageAnalysisModel>(json);
  }
}

mixin AiImageAnalysisModelMappable {
  String toJson() {
    return AiImageAnalysisModelMapper.ensureInitialized()
        .encodeJson<AiImageAnalysisModel>(this as AiImageAnalysisModel);
  }

  Map<String, dynamic> toMap() {
    return AiImageAnalysisModelMapper.ensureInitialized()
        .encodeMap<AiImageAnalysisModel>(this as AiImageAnalysisModel);
  }

  AiImageAnalysisModelCopyWith<
    AiImageAnalysisModel,
    AiImageAnalysisModel,
    AiImageAnalysisModel
  >
  get copyWith =>
      _AiImageAnalysisModelCopyWithImpl<
        AiImageAnalysisModel,
        AiImageAnalysisModel
      >(this as AiImageAnalysisModel, $identity, $identity);
  @override
  String toString() {
    return AiImageAnalysisModelMapper.ensureInitialized().stringifyValue(
      this as AiImageAnalysisModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AiImageAnalysisModelMapper.ensureInitialized().equalsValue(
      this as AiImageAnalysisModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AiImageAnalysisModelMapper.ensureInitialized().hashValue(
      this as AiImageAnalysisModel,
    );
  }
}

extension AiImageAnalysisModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AiImageAnalysisModel, $Out> {
  AiImageAnalysisModelCopyWith<$R, AiImageAnalysisModel, $Out>
  get $asAiImageAnalysisModel => $base.as(
    (v, t, t2) => _AiImageAnalysisModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AiImageAnalysisModelCopyWith<
  $R,
  $In extends AiImageAnalysisModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? text});
  AiImageAnalysisModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AiImageAnalysisModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AiImageAnalysisModel, $Out>
    implements AiImageAnalysisModelCopyWith<$R, AiImageAnalysisModel, $Out> {
  _AiImageAnalysisModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AiImageAnalysisModel> $mapper =
      AiImageAnalysisModelMapper.ensureInitialized();
  @override
  $R call({String? text}) =>
      $apply(FieldCopyWithData({if (text != null) #text: text}));
  @override
  AiImageAnalysisModel $make(CopyWithData data) =>
      AiImageAnalysisModel(data.get(#text, or: $value.text));

  @override
  AiImageAnalysisModelCopyWith<$R2, AiImageAnalysisModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AiImageAnalysisModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

