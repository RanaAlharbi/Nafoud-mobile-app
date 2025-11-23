// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'authentication_model.dart';

class AuthenticationModelMapper extends ClassMapperBase<AuthenticationModel> {
  AuthenticationModelMapper._();

  static AuthenticationModelMapper? _instance;
  static AuthenticationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthenticationModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AuthenticationModel';

  static String _$accessToken(AuthenticationModel v) => v.accessToken;
  static const Field<AuthenticationModel, String> _f$accessToken = Field(
    'accessToken',
    _$accessToken,
  );
  static String _$refreshToken(AuthenticationModel v) => v.refreshToken;
  static const Field<AuthenticationModel, String> _f$refreshToken = Field(
    'refreshToken',
    _$refreshToken,
  );

  @override
  final MappableFields<AuthenticationModel> fields = const {
    #accessToken: _f$accessToken,
    #refreshToken: _f$refreshToken,
  };

  static AuthenticationModel _instantiate(DecodingData data) {
    return AuthenticationModel(
      accessToken: data.dec(_f$accessToken),
      refreshToken: data.dec(_f$refreshToken),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AuthenticationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthenticationModel>(map);
  }

  static AuthenticationModel fromJson(String json) {
    return ensureInitialized().decodeJson<AuthenticationModel>(json);
  }
}

mixin AuthenticationModelMappable {
  String toJson() {
    return AuthenticationModelMapper.ensureInitialized()
        .encodeJson<AuthenticationModel>(this as AuthenticationModel);
  }

  Map<String, dynamic> toMap() {
    return AuthenticationModelMapper.ensureInitialized()
        .encodeMap<AuthenticationModel>(this as AuthenticationModel);
  }

  AuthenticationModelCopyWith<
    AuthenticationModel,
    AuthenticationModel,
    AuthenticationModel
  >
  get copyWith =>
      _AuthenticationModelCopyWithImpl<
        AuthenticationModel,
        AuthenticationModel
      >(this as AuthenticationModel, $identity, $identity);
  @override
  String toString() {
    return AuthenticationModelMapper.ensureInitialized().stringifyValue(
      this as AuthenticationModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthenticationModelMapper.ensureInitialized().equalsValue(
      this as AuthenticationModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthenticationModelMapper.ensureInitialized().hashValue(
      this as AuthenticationModel,
    );
  }
}

extension AuthenticationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthenticationModel, $Out> {
  AuthenticationModelCopyWith<$R, AuthenticationModel, $Out>
  get $asAuthenticationModel => $base.as(
    (v, t, t2) => _AuthenticationModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthenticationModelCopyWith<
  $R,
  $In extends AuthenticationModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? accessToken, String? refreshToken});
  AuthenticationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthenticationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthenticationModel, $Out>
    implements AuthenticationModelCopyWith<$R, AuthenticationModel, $Out> {
  _AuthenticationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthenticationModel> $mapper =
      AuthenticationModelMapper.ensureInitialized();
  @override
  $R call({String? accessToken, String? refreshToken}) => $apply(
    FieldCopyWithData({
      if (accessToken != null) #accessToken: accessToken,
      if (refreshToken != null) #refreshToken: refreshToken,
    }),
  );
  @override
  AuthenticationModel $make(CopyWithData data) => AuthenticationModel(
    accessToken: data.get(#accessToken, or: $value.accessToken),
    refreshToken: data.get(#refreshToken, or: $value.refreshToken),
  );

  @override
  AuthenticationModelCopyWith<$R2, AuthenticationModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AuthenticationModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

