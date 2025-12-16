// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'my_activity_model.dart';

class MyActivityModelMapper extends ClassMapperBase<MyActivityModel> {
  MyActivityModelMapper._();

  static MyActivityModelMapper? _instance;
  static MyActivityModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MyActivityModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MyActivityModel';

  static String _$id(MyActivityModel v) => v.id;
  static const Field<MyActivityModel, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<MyActivityModel> fields = const {#id: _f$id};

  static MyActivityModel _instantiate(DecodingData data) {
    return MyActivityModel(id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static MyActivityModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MyActivityModel>(map);
  }

  static MyActivityModel fromJson(String json) {
    return ensureInitialized().decodeJson<MyActivityModel>(json);
  }
}

mixin MyActivityModelMappable {
  String toJson() {
    return MyActivityModelMapper.ensureInitialized()
        .encodeJson<MyActivityModel>(this as MyActivityModel);
  }

  Map<String, dynamic> toMap() {
    return MyActivityModelMapper.ensureInitialized().encodeMap<MyActivityModel>(
      this as MyActivityModel,
    );
  }

  MyActivityModelCopyWith<MyActivityModel, MyActivityModel, MyActivityModel>
  get copyWith =>
      _MyActivityModelCopyWithImpl<MyActivityModel, MyActivityModel>(
        this as MyActivityModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MyActivityModelMapper.ensureInitialized().stringifyValue(
      this as MyActivityModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return MyActivityModelMapper.ensureInitialized().equalsValue(
      this as MyActivityModel,
      other,
    );
  }

  @override
  int get hashCode {
    return MyActivityModelMapper.ensureInitialized().hashValue(
      this as MyActivityModel,
    );
  }
}

extension MyActivityModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MyActivityModel, $Out> {
  MyActivityModelCopyWith<$R, MyActivityModel, $Out> get $asMyActivityModel =>
      $base.as((v, t, t2) => _MyActivityModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MyActivityModelCopyWith<$R, $In extends MyActivityModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id});
  MyActivityModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MyActivityModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MyActivityModel, $Out>
    implements MyActivityModelCopyWith<$R, MyActivityModel, $Out> {
  _MyActivityModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MyActivityModel> $mapper =
      MyActivityModelMapper.ensureInitialized();
  @override
  $R call({String? id}) => $apply(FieldCopyWithData({if (id != null) #id: id}));
  @override
  MyActivityModel $make(CopyWithData data) =>
      MyActivityModel(id: data.get(#id, or: $value.id));

  @override
  MyActivityModelCopyWith<$R2, MyActivityModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MyActivityModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

