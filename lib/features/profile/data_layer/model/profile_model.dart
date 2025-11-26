import 'package:dart_mappable/dart_mappable.dart';
import '../../domain_layer/entity/profile_entity.dart';

part 'profile_model.mapper.dart';

@MappableClass()
class ProfileModel extends ProfileEntity with ProfileModelMappable {
  const ProfileModel({
    required super.id,
    required super.username,
    required super.email,
    super.phoneNumber,
    super.avatarUrl,
    required super.status,
    required super.isActive,
    super.deletedAt,
    super.deletionReason,
    super.lastLoginAt,
    required super.deactivationCount,
    super.createdAt,
    super.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      status: json['status'] as String? ?? 'active',
      isActive: json['is_active'] as bool? ?? true,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
      deletionReason: json['deletion_reason'] as String?,
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.parse(json['last_login_at'] as String)
          : null,
      deactivationCount: json['deactivation_count'] as int? ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'avatar_url': avatarUrl,
      'status': status,
      'is_active': isActive,
      'deleted_at': deletedAt?.toIso8601String(),
      'deletion_reason': deletionReason,
      'last_login_at': lastLoginAt?.toIso8601String(),
      'deactivation_count': deactivationCount,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
