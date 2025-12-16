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
                      "Terms & Conditions",
                      style: GoogleFonts.cairo(
                        fontSize: 25.9.sp,
                        color: const Color(0xFF3D4032),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Please read the following terms & conditions carefully before continuing.",
                      style: GoogleFonts.cairo(
                        fontSize: 18.sp,
                        color: const Color(0xFF919191),
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
                        alignment: Alignment.topLeft,
                        child: Text(
                          "1. Acceptance of Terms",
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "By creating an account or using the app, you agree to comply with these Terms & Conditions. If you do not agree, please stop using the app.",
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "2. Purpose of the App",
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "Nufud helps users discover events, explore experiences, plan trips, and interact with AI-powered features such as image analysis and recommendations. The app is for personal, non-commercial use only.",
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "3. User Responsibilities",
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow("You agree to:"),
                      _buildBulletPoint(
                        "Use the app respectfully and lawfully.",
                      ),
                      _buildBulletPoint(
                        "Provide accurate information when creating an account.",
                      ),
                      _buildBulletPoint(
                        "Not misuse any feature, including AI tools, image uploads, or event posting.",
                      ),
                      _buildBulletPoint(
                        "Not upload harmful, inappropriate, or copyrighted content that you do not own.",
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "4. Event Posting & Community Content",
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow("If you post an event or activity:"),
                      _buildBulletPoint(
                        "You are responsible for the accuracy of your information.",
                      ),
                      _buildBulletPoint(
                        "Nufud does not verify or guarantee event details.",
                      ),
                      _buildBulletPoint(
                        "Nufud is not responsible for interactions between users or for any issues that occur during events.",
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "5. AI Features",
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "Nufud includes AI features such as trip planning, recommendations, and image analysis. These features:",
                      ),
                      _buildBulletPoint(
                        "Provide suggestions only, not guarantees.",
                      ),
                      _buildBulletPoint(
                        "May not always be accurate or complete.",
                      ),
                      _buildBulletPoint(
                        "Should not be used for safety-critical decisions.",
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "6. Privacy & Data",
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "We collect and process data to improve your experience. This may include:",
                      ),
                      _buildBulletPoint("Account information"),
                      _buildBulletPoint("Uploaded images"),
                      _buildBulletPoint("Location (if you choose to allow it)"),
                      _buildBulletPoint("App usage analytics"),
                      _buildBulletPoint(
                        "We do not sell your personal data to third parties. For more details, refer to our Privacy Policy.",
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "7. Prohibited Activities",
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow("You agree NOT to:"),
                      _buildBulletPoint(
                        "Use the app for illegal or harmful activities.",
                      ),
                      _buildBulletPoint(
                        "Upload content containing violence, hate, harassment, or explicit material.",
                      ),
                      _buildBulletPoint(
                        "Attempt to hack, reverse engineer, or misuse the app.",
                      ),
                      _buildBulletPoint(
                        "Impersonate other users or create fake content.",
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "8. Intellectual Property",
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "All branding, design, content, and app features belong to Nufud. You may not copy, reproduce, or redistribute any part of the app without permission.",
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "9. Limitation of Liability",
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow("Nufud is not responsible for:"),
                      _buildBulletPoint(
                        "Event cancellations, misinformation, or disputes between users",
                      ),
                      _buildBulletPoint(
                        "Damages resulting from the use of AI features",
                      ),
                      _buildBulletPoint("Loss of data or technical issues"),
                      _buildBulletPoint("You use the app at your own risk."),

                      10.verticalSpace,

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "10. Changes to the Terms",
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "We may update these Terms from time to time. If changes are made, we will notify users in the app. Continued use means you accept the updated Terms.",
                      ),

                      10.verticalSpace,

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "11. Contact",
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildTextRow(
                        "If you have questions or concerns, please contact us: support@nafoud.app",
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
                          "Agree",
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
