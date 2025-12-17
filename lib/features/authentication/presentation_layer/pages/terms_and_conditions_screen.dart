import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: GoogleFonts.cairo(
              fontSize: 15.sp,
              color: const Color(0xFF919191),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.cairo(
                fontSize: 15.sp,
                color: const Color(0xFF919191),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextRow(String text) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.cairo(
              fontSize: 15.sp,
              color: const Color(0xFF919191),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                'Assets/authentication/BackgroundLetters.svg',
                width: 419.w,
                height: 774.h,
                fit: BoxFit.contain,
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 265,
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                decoration: const BoxDecoration(color: Color(0xFFF1F1F1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    21.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      textDirection: .ltr,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.maybePop(context);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/arrow_left.svg',
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/logo/NafoudLogo.svg',
                          width: 67.87.w,
                          height: 69.17.h,
                        ),
                      ],
                    ),
                    58.verticalSpace,

                    Text(
                      "termsAndConditions.title".tr(),
                      style: GoogleFonts.cairo(
                        fontSize: 25.9.sp,
                        color: const Color(0xFF3D4032),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "termsAndConditions.subtitle".tr(),
                        style: GoogleFonts.cairo(
                          fontSize: 18.sp,
                          color: const Color(0xFF919191),
                        ),
                      ),
                    ),
                    22.verticalSpace,
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 240, bottom: 62.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "termsAndConditions.section1Title".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "termsAndConditions.section1Text".tr(),
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "termsAndConditions.section2Title".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "termsAndConditions.section2Text".tr(),
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "termsAndConditions.section3Title".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow("termsAndConditions.section3Text".tr()),
                      _buildBulletPoint(
                        "termsAndConditions.section3Bullet1".tr(),
                      ),
                      _buildBulletPoint(
                        "termsAndConditions.section3Bullet2".tr(),
                      ),
                      _buildBulletPoint(
                        "termsAndConditions.section3Bullet3".tr(),
                      ),
                      _buildBulletPoint(
                        "termsAndConditions.section3Bullet4".tr(),
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "termsAndConditions.section4Title".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow("termsAndConditions.section4Text".tr()),
                      _buildBulletPoint(
                        "termsAndConditions.section4Bullet1".tr(),
                      ),
                      _buildBulletPoint(
                        "termsAndConditions.section4Bullet2".tr(),
                      ),
                      _buildBulletPoint(
                        "termsAndConditions.section4Bullet3".tr(),
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "termsAndConditions.section5Title".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "termsAndConditions.section5Text".tr(),
                      ),
                      _buildBulletPoint(
                        "termsAndConditions.section5Bullet1".tr(),
                      ),
                      _buildBulletPoint(
                        "termsAndConditions.section5Bullet2".tr(),
                      ),
                      _buildBulletPoint(
                        "termsAndConditions.section5Bullet3".tr(),
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "termsAndConditions.section6Title".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "termsAndConditions.section6Text".tr(),
                      ),
                      _buildBulletPoint("termsAndConditions.section6Bullet1".tr()),
                      _buildBulletPoint("termsAndConditions.section6Bullet2".tr()),
                      _buildBulletPoint("termsAndConditions.section6Bullet3".tr()),
                      _buildBulletPoint("termsAndConditions.section6Bullet4".tr()),
                      _buildBulletPoint(
                        "termsAndConditions.section6Bullet5".tr(),
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "termsAndConditions.section7Title".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow("termsAndConditions.section7Text".tr()),
                      _buildBulletPoint(
                        "termsAndConditions.section7Bullet1".tr(),
                      ),
                      _buildBulletPoint(
                        "termsAndConditions.section7Bullet2".tr(),
                      ),
                      _buildBulletPoint(
                        "termsAndConditions.section7Bullet3".tr(),
                      ),
                      _buildBulletPoint(
                        "termsAndConditions.section7Bullet4".tr(),
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "termsAndConditions.section8Title".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "termsAndConditions.section8Text".tr(),
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "termsAndConditions.section9Title".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow("termsAndConditions.section9Text".tr()),
                      _buildBulletPoint(
                        "termsAndConditions.section9Bullet1".tr(),
                      ),
                      _buildBulletPoint(
                        "termsAndConditions.section9Bullet2".tr(),
                      ),
                      _buildBulletPoint("termsAndConditions.section9Bullet3".tr()),
                      _buildBulletPoint("termsAndConditions.section9Bullet4".tr()),

                      10.verticalSpace,

                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "termsAndConditions.section10Title".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "termsAndConditions.section10Text".tr(),
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "termsAndConditions.section11Title".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "termsAndConditions.section11Text".tr(),
                      ),

                      20.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 62,
                color: const Color(0xFFF1F1F1),
                padding: EdgeInsets.only(bottom: 14.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.pop(true);
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(360.w, 42.h),
                          backgroundColor: const Color(0xFF656A53),
                          foregroundColor: const Color(0xFFF0F0EE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          "termsAndConditions.agree".tr(),
                          style: GoogleFonts.cairo(fontSize: 18.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
