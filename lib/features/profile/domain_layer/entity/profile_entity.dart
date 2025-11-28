import 'package:equatable/equatable.dart';

// Comments here r for things that we won't do + we might change this later on
class ProfileEntity extends Equatable {
  final String id; 
  final String username; // username (like @username)
  final String fullName; // full name
  final String email;
  final String? phoneNumber;
  final String? avatarUrl;

  // 'deleted' = soft delete | 'suspended' = account blocked by admin | 'deactivated' = account deactivated temporarily by user
  final String status; // 'active', 'deleted', 'suspended', 'deactivated'
  final bool isActive;
  // final DateTime? deletedAt;
  // final String? deletionReason;  | Do we need to ask the user why s/he wants to delete her/his account?
  final DateTime? lastLoginAt;
  // final int deactivationCount;
  final DateTime? createdAt;
  // final DateTime? updatedAt;
  // I need to add gender here

  const ProfileEntity({
    required this.id,
    required this.username,
    required this.fullName,
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
        fullName,
        email,
        phoneNumber,
        avatarUrl,
        status,
        isActive,
        lastLoginAt,
        createdAt,
      ];
}
