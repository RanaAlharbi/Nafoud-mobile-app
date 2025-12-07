// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'error_page_model.dart';

class ErrorPageModelMapper extends ClassMapperBase<ErrorPageModel> {
  ErrorPageModelMapper._();

  static ErrorPageModelMapper? _instance;
  static ErrorPageModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ErrorPageModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ErrorPageModel';

  static String _$id(ErrorPageModel v) => v.id;
  static const Field<ErrorPageModel, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<ErrorPageModel> fields = const {#id: _f$id};

  static ErrorPageModel _instantiate(DecodingData data) {
    return ErrorPageModel(id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static ErrorPageModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ErrorPageModel>(map);
  }

  static ErrorPageModel fromJson(String json) {
    return ensureInitialized().decodeJson<ErrorPageModel>(json);
  }
}

mixin ErrorPageModelMappable {
  String toJson() {
    return ErrorPageModelMapper.ensureInitialized().encodeJson<ErrorPageModel>(
      this as ErrorPageModel,
    );
  }

  Map<String, dynamic> toMap() {
    return ErrorPageModelMapper.ensureInitialized().encodeMap<ErrorPageModel>(
      this as ErrorPageModel,
    );
  }

  ErrorPageModelCopyWith<ErrorPageModel, ErrorPageModel, ErrorPageModel>
  get copyWith => _ErrorPageModelCopyWithImpl<ErrorPageModel, ErrorPageModel>(
    this as ErrorPageModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ErrorPageModelMapper.ensureInitialized().stringifyValue(
      this as ErrorPageModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ErrorPageModelMapper.ensureInitialized().equalsValue(
      this as ErrorPageModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ErrorPageModelMapper.ensureInitialized().hashValue(
      this as ErrorPageModel,
    );
  }
}

extension ErrorPageModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ErrorPageModel, $Out> {
  ErrorPageModelCopyWith<$R, ErrorPageModel, $Out> get $asErrorPageModel =>
      $base.as((v, t, t2) => _ErrorPageModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ErrorPageModelCopyWith<$R, $In extends ErrorPageModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id});
  ErrorPageModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ErrorPageModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ErrorPageModel, $Out>
    implements ErrorPageModelCopyWith<$R, ErrorPageModel, $Out> {
  _ErrorPageModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ErrorPageModel> $mapper =
      ErrorPageModelMapper.ensureInitialized();
  @override
  $R call({String? id}) => $apply(FieldCopyWithData({if (id != null) #id: id}));
  @override
  ErrorPageModel $make(CopyWithData data) =>
      ErrorPageModel(id: data.get(#id, or: $value.id));

  @override
  ErrorPageModelCopyWith<$R2, ErrorPageModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ErrorPageModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

