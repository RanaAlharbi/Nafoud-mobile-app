import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class EmbassyDropdownCard extends StatelessWidget {
  final Map<String, String> embassies;
  final String? selectedEmbassy;
  final ValueChanged<String?>? onEmbassySelected;

  const EmbassyDropdownCard({
    super.key,
    required this.embassies,
    this.selectedEmbassy,
    this.onEmbassySelected,
  });

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectedEmbassy != null
          ? () => _makePhoneCall(embassies[selectedEmbassy]!)
          : null,
      child: Container(
        padding: EdgeInsets.all(16.w),
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
                    child: Icon(
                      Icons.language,
                      size: 30.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Embassies',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 8.h),

            // Dropdown
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedEmbassy,
                hint: Text(
                  'Select',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                isExpanded: true,
                menuMaxHeight: 350.h,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                icon: SvgPicture.asset(
                  'assets/icons/down_arrow.svg',
                  width: 9.sp,
                  height: 9.sp,
                ),
                items: embassies.keys.map((embassy) {
                  return DropdownMenuItem<String>(
                    value: embassy,
                    child: Text(embassy),
                  );
                }).toList(),
                onChanged: onEmbassySelected,
              ),
            ),

            if (selectedEmbassy != null) ...[
              SizedBox(height: 4.h),
              Text(
                embassies[selectedEmbassy]!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
