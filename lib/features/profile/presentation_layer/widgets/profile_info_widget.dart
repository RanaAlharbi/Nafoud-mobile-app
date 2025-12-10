import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatelessWidget {
  final String? fullName;
  final String? username;
  final String? email;
  final String? phoneNumber;

  const ProfileInfoWidget({
    super.key,
    this.fullName,
    this.username,
    this.email,
    this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Full name
        Text(
          fullName ?? 'Loading the name...',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
