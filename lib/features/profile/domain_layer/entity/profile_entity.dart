import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String username;
  final String email;
  final String? phoneNumber;
  final String? avatarUrl;
  
  // 'deleted' = soft delete | 'suspended' = account blocked by admin | 'deactivated' = account deactivated temporarily by user
  final String status; // 'active', 'deleted', 'suspended', 'deactivated'  
  final bool isActive;
  // final DateTime? deletedAt;
  // final String? deletionReason;
  final DateTime? lastLoginAt;
  // final int deactivationCount;
  final DateTime? createdAt;
  // final DateTime? updatedAt;

  const ProfileEntity({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber,
    this.avatarUrl,
    required this.status,
    required this.isActive,
    this.lastLoginAt,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        phoneNumber,
        avatarUrl,
        status,
        isActive,
        lastLoginAt,
        createdAt,
      ];
}
