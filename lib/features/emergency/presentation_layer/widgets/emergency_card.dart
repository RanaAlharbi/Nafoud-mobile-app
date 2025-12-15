import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyCard extends StatelessWidget {
  final String title;
  final String number;
  final String? description;
  final String iconUrl;
  final VoidCallback? onTap;

  const EmergencyCard({
    super.key,
    required this.title,
    required this.number,
    this.description,
    required this.iconUrl,
    this.onTap,
  });

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => _makePhoneCall(number),
      child: Container(
        padding: EdgeInsets.all(16.w),
        // Cover color that shows behind the images
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container with double frame
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 70.w,
                height: 70.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 67.w,
                    height: 67.w,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(239, 240, 237, 1),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: iconUrl.startsWith('assets/')
                          ? Image.asset(
                              iconUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.phone, size: 30.sp, color: Colors.grey),
                            )
                          : iconUrl.endsWith('.svg')
                              ? SvgPicture.network(
                                  iconUrl,
                                  fit: BoxFit.contain,
                                  placeholderBuilder: (context) => Icon(
                                    Icons.phone,
                                    size: 30.sp,
                                    color: Colors.grey,
                                  ),
                                )
                              : Image.network(
                                  iconUrl,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.phone, size: 30.sp, color: Colors.grey),
                                ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Title and Number - layout based on title length
            title.length > 15 || number.length > 5
                ? Column(
                    children: [
                      // Title
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      // Number
                      Text(
                        number,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: .bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      // Number
                      Text(
                        number,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: .bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 4.h),

            if (description != null) ...[
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  description!,
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
