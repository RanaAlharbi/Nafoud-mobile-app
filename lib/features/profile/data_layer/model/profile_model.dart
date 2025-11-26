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
    super.lastLoginAt,
    super.createdAt,
  });
}
