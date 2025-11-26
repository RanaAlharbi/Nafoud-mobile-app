// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'profile_model.dart';

class ProfileModelMapper extends ClassMapperBase<ProfileModel> {
  ProfileModelMapper._();

  static ProfileModelMapper? _instance;
  static ProfileModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileModel';

  static String _$id(ProfileModel v) => v.id;
  static const Field<ProfileModel, String> _f$id = Field('id', _$id);
  static String _$username(ProfileModel v) => v.username;
  static const Field<ProfileModel, String> _f$username = Field(
    'username',
    _$username,
  );
  static String _$email(ProfileModel v) => v.email;
  static const Field<ProfileModel, String> _f$email = Field('email', _$email);
  static String? _$phoneNumber(ProfileModel v) => v.phoneNumber;
  static const Field<ProfileModel, String> _f$phoneNumber = Field(
    'phoneNumber',
    _$phoneNumber,
    opt: true,
  );
  static String? _$avatarUrl(ProfileModel v) => v.avatarUrl;
  static const Field<ProfileModel, String> _f$avatarUrl = Field(
    'avatarUrl',
    _$avatarUrl,
    opt: true,
  );
  static String _$status(ProfileModel v) => v.status;
  static const Field<ProfileModel, String> _f$status = Field(
    'status',
    _$status,
  );
  static bool _$isActive(ProfileModel v) => v.isActive;
  static const Field<ProfileModel, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
  );
  static DateTime? _$deletedAt(ProfileModel v) => v.deletedAt;
  static const Field<ProfileModel, DateTime> _f$deletedAt = Field(
    'deletedAt',
    _$deletedAt,
    opt: true,
  );
  static String? _$deletionReason(ProfileModel v) => v.deletionReason;
  static const Field<ProfileModel, String> _f$deletionReason = Field(
    'deletionReason',
    _$deletionReason,
    opt: true,
  );
  static DateTime? _$lastLoginAt(ProfileModel v) => v.lastLoginAt;
  static const Field<ProfileModel, DateTime> _f$lastLoginAt = Field(
    'lastLoginAt',
    _$lastLoginAt,
    opt: true,
  );
  static int _$deactivationCount(ProfileModel v) => v.deactivationCount;
  static const Field<ProfileModel, int> _f$deactivationCount = Field(
    'deactivationCount',
    _$deactivationCount,
  );
  static DateTime? _$createdAt(ProfileModel v) => v.createdAt;
  static const Field<ProfileModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static DateTime? _$updatedAt(ProfileModel v) => v.updatedAt;
  static const Field<ProfileModel, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );

  @override
  final MappableFields<ProfileModel> fields = const {
    #id: _f$id,
    #username: _f$username,
    #email: _f$email,
    #phoneNumber: _f$phoneNumber,
    #avatarUrl: _f$avatarUrl,
    #status: _f$status,
    #isActive: _f$isActive,
    #deletedAt: _f$deletedAt,
    #deletionReason: _f$deletionReason,
    #lastLoginAt: _f$lastLoginAt,
    #deactivationCount: _f$deactivationCount,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static ProfileModel _instantiate(DecodingData data) {
    return ProfileModel(
      id: data.dec(_f$id),
      username: data.dec(_f$username),
      email: data.dec(_f$email),
      phoneNumber: data.dec(_f$phoneNumber),
      avatarUrl: data.dec(_f$avatarUrl),
      status: data.dec(_f$status),
      isActive: data.dec(_f$isActive),
      deletedAt: data.dec(_f$deletedAt),
      deletionReason: data.dec(_f$deletionReason),
      lastLoginAt: data.dec(_f$lastLoginAt),
      deactivationCount: data.dec(_f$deactivationCount),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileModel>(map);
  }

  static ProfileModel fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileModel>(json);
  }
}

mixin ProfileModelMappable {
  String toJson() {
    return ProfileModelMapper.ensureInitialized().encodeJson<ProfileModel>(
      this as ProfileModel,
    );
  }

  Map<String, dynamic> toMap() {
    return ProfileModelMapper.ensureInitialized().encodeMap<ProfileModel>(
      this as ProfileModel,
    );
  }

  ProfileModelCopyWith<ProfileModel, ProfileModel, ProfileModel> get copyWith =>
      _ProfileModelCopyWithImpl<ProfileModel, ProfileModel>(
        this as ProfileModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProfileModelMapper.ensureInitialized().stringifyValue(
      this as ProfileModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProfileModelMapper.ensureInitialized().equalsValue(
      this as ProfileModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ProfileModelMapper.ensureInitialized().hashValue(
      this as ProfileModel,
    );
  }
}

extension ProfileModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileModel, $Out> {
  ProfileModelCopyWith<$R, ProfileModel, $Out> get $asProfileModel =>
      $base.as((v, t, t2) => _ProfileModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileModelCopyWith<$R, $In extends ProfileModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? username,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
    String? status,
    bool? isActive,
    DateTime? deletedAt,
    String? deletionReason,
    DateTime? lastLoginAt,
    int? deactivationCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  ProfileModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileModel, $Out>
    implements ProfileModelCopyWith<$R, ProfileModel, $Out> {
  _ProfileModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileModel> $mapper =
      ProfileModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? username,
    String? email,
    Object? phoneNumber = $none,
    Object? avatarUrl = $none,
    String? status,
    bool? isActive,
    Object? deletedAt = $none,
    Object? deletionReason = $none,
    Object? lastLoginAt = $none,
    int? deactivationCount,
    Object? createdAt = $none,
    Object? updatedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (username != null) #username: username,
      if (email != null) #email: email,
      if (phoneNumber != $none) #phoneNumber: phoneNumber,
      if (avatarUrl != $none) #avatarUrl: avatarUrl,
      if (status != null) #status: status,
      if (isActive != null) #isActive: isActive,
      if (deletedAt != $none) #deletedAt: deletedAt,
      if (deletionReason != $none) #deletionReason: deletionReason,
      if (lastLoginAt != $none) #lastLoginAt: lastLoginAt,
      if (deactivationCount != null) #deactivationCount: deactivationCount,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
    }),
  );
  @override
  ProfileModel $make(CopyWithData data) => ProfileModel(
    id: data.get(#id, or: $value.id),
    username: data.get(#username, or: $value.username),
    email: data.get(#email, or: $value.email),
    phoneNumber: data.get(#phoneNumber, or: $value.phoneNumber),
    avatarUrl: data.get(#avatarUrl, or: $value.avatarUrl),
    status: data.get(#status, or: $value.status),
    isActive: data.get(#isActive, or: $value.isActive),
    deletedAt: data.get(#deletedAt, or: $value.deletedAt),
    deletionReason: data.get(#deletionReason, or: $value.deletionReason),
    lastLoginAt: data.get(#lastLoginAt, or: $value.lastLoginAt),
    deactivationCount: data.get(
      #deactivationCount,
      or: $value.deactivationCount,
    ),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  ProfileModelCopyWith<$R2, ProfileModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProfileModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

