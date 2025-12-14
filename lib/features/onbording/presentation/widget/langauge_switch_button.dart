import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageSwitchButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String languageCode;

  const LanguageSwitchButton({
    super.key,
    this.onTap,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Color(0xff787878).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.globe,
              size: 16.sp,
              color: CupertinoColors.white,
            ),
            6.horizontalSpace,
            Text(
              languageCode,
              style: GoogleFonts.cairo(
                color: CupertinoColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
