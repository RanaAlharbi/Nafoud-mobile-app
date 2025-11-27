import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final bool isUploading;
  final VoidCallback onEditTap;

  const ProfileAvatarWidget({
    super.key,
    this.avatarUrl,
    required this.isUploading,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.r,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Circle
          Positioned(
            top: -280.h,
            left: (1.sw - 445.w) / 2,
            child: Container(
              height: 390.sp,
              clipBehavior: Clip.none,
              width: 445.w,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 248, 232, 1),
                borderRadius: BorderRadius.circular(445.w),
              ),
            ),
          ),

          // Avatar
          Positioned(
            top: 0,
            left: (1.sw - 140.r) / 2,
            child: CircleAvatar(
              radius: 70.r,
              backgroundColor: const Color.fromARGB(255, 201, 189, 161),
              backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
              child: avatarUrl == null
                  ? Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 70.sp,
                    )
                  : null,
            ),
          ),

          // Edit button background circle
          Positioned(
            bottom: -2.w,
            left: (1.sw - 140.r) / 2 + 96.r,
            child: CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.white,
            ),
          ),

          // Edit button
          Positioned(
            bottom: 0,
            left: (1.sw - 140.r) / 2 + 98.r,
            child: GestureDetector(
              onTap: onEditTap,
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
                child: isUploading
                    ? SizedBox(
                        width: 16.sp,
                        height: 16.sp,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      )
                    : Icon(
                        RemixIcons.edit_line,
                        color: Colors.black,
                        size: 23.sp,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
