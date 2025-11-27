import 'package:dart_mappable/dart_mappable.dart';
import '../../domain_layer/entity/profile_entity.dart';

part 'profile_model.mapper.dart';

@MappableClass()
class ProfileModel extends ProfileEntity with ProfileModelMappable {
  const ProfileModel({
    required super.id,
    required super.username,
    @MappableField(key: 'full_name') required super.fullName,
    required super.email,
    @MappableField(key: 'phone_number') super.phoneNumber,
    @MappableField(key: 'avatar_url') super.avatarUrl,
    required super.status,
    @MappableField(key: 'is_active') required super.isActive,
    @MappableField(key: 'last_login_at') super.lastLoginAt,
    @MappableField(key: 'created_at') super.createdAt,
    // I need to add gender here
  });
}
