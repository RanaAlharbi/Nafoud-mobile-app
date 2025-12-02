import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
            color: Color.fromRGBO(103, 70, 54, 1),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        // Username
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '@${username ?? 'Loading_The_Username...'}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Gap(4),
        // Email and Phone
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${email ?? 'Loading Email...'} | ',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              phoneNumber == null
                  ? 'Loading Number...'
                  : phoneNumber == ''
                      ? 'No Phone Number'
                      : phoneNumber!,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
