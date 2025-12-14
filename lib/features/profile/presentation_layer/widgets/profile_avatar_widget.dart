import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final bool isUploading;
  final VoidCallback onEditTap;
  final String? fullName;

  const ProfileAvatarWidget({
    super.key,
    this.avatarUrl,
    required this.isUploading,
    required this.onEditTap,
    this.fullName,
  });

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '';

    final words = name.trim().split(' ').where((word) => word.isNotEmpty).toList();

    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();

    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.r,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Avatar
          Positioned(
            top: 0,
            left: (1.sw - 140.r) / 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 140.r,
                  height: 140.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: avatarUrl != null
                          ? const Color.fromRGBO(101, 106, 83, 1) // 656A53 hex
                          : const Color.fromRGBO(194, 164, 128, 1),
                      width: 3.w,
                    ),
                  ),
                  child: CircleAvatar(
                    key: ValueKey(avatarUrl ?? 'default'),
                    radius: 70.r,
                    backgroundColor: const Color.fromRGBO(237, 234, 231, 1), // EDEAE7 hex
                    child: avatarUrl != null
                        ? CachedNetworkImage(
                            imageUrl: avatarUrl!,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 140.r,
                              height: 140.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => const CircularProgressIndicator(
                              color: Color.fromRGBO(194, 164, 128, 1),
                            ),
                            errorWidget: (context, url, error) {
                              final initials = _getInitials(fullName);
                              return initials.isNotEmpty
                                  ? Text(
                                      initials,
                                      style: TextStyle(
                                        color: const Color.fromRGBO(194, 164, 128, 1), // C2A480 hex
                                        fontSize: 50.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      color: const Color.fromRGBO(194, 164, 128, 1),
                                      size: 70.sp,
                                    );
                            },
                          )
                        : _getInitials(fullName).isNotEmpty
                            ? Text(
                                _getInitials(fullName),
                                style: TextStyle(
                                  color: const Color.fromRGBO(194, 164, 128, 1), // C2A480 hex
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                color: const Color.fromRGBO(194, 164, 128, 1),
                                size: 70.sp,
                              ),
                  ),
                ),
                // Loading overlay on the main avatar
                if (isUploading)
                  Container(
                    width: 140.r,
                    height: 140.r,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Edit button background circle (hidden when uploading)
          if (!isUploading)
            Positioned(
              bottom: -2.w,
              left: (1.sw - 140.r) / 2 + 96.r,
              child: CircleAvatar(
                radius: 20.r,
                // It's not usable rigth now cus the UI/UX team choosed not to. 
                // But we can change this thing here incase if we want it
                // const Color.fromRGBO(240, 240, 238, 1)
                backgroundColor: Colors.white, 
              ),
            ),

          // Edit button (hidden when uploading)
          if (!isUploading)
            Positioned(
              bottom: 0,
              left: (1.sw - 140.r) / 2 + 98.r,
              child: GestureDetector(
                onTap: onEditTap,
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundColor: Colors.white  ,
                  child: SvgPicture.asset(
                    'assets/icons/edit-user-02.svg',
                    width: 23.sp,
                    height: 23.sp,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
