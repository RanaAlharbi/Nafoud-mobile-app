import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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

            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    children: [
                      21.verticalSpace,
                      Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset(
                          'assets/logo/NafoudLogo.svg',
                          width: 67.87.w,
                          height: 69.17.h,
                        ),
                      ),
                      58.83.verticalSpace,

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Terms & Conditions",
                          style: GoogleFonts.cairo(
                            fontSize: 25.9.sp,
                            color: const Color(0xFF3D4032),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Column(
                        children: [
                          Text(
                            "Please read the following terms & conditions carefully before continuing.",
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: const Color(0xFF919191),
                            ),
                          ),

                          22.verticalSpace,
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

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "By creating an account or using the app, you agree to comply with these Terms & Conditions. If you do not agree, please stop using the app.",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF919191),
                                  ),
                                ),
                              ),
                            ],
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

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Nufud helps users discover events, explore experiences, plan trips, and interact with AI-powered features such as image analysis and recommendations. The app is for personal, non-commercial use only.",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF919191),
                                  ),
                                ),
                              ),
                            ],
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

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "You agree to:\n. Use the app respectfully and lawfully.\n. Provide accurate information when creating an account.\n. Not misuse any feature, including AI tools, image uploads, or event posting.\n. Not upload harmful, inappropriate, or copyrighted content that you do not own.",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF919191),
                                  ),
                                ),
                              ),
                            ],
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

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "If you post an event or activity:\n. You are responsible for the accuracy of your information.\n. Nufud does not verify or guarantee event details.\n. Nufud is not responsible for interactions between users or for any issues that occur during events.",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF919191),
                                  ),
                                ),
                              ),
                            ],
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

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Nufud includes AI features such as trip planning, recommendations, and image analysis.\nThese features:\n. Provide suggestions only, not guarantees.\n. May not always be accurate or complete.\n. Should not be used for safety-critical decisions.",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF919191),
                                  ),
                                ),
                              ),
                            ],
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

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "We collect and process data to improve your experience. This may include:\n. Account information\n. Uploaded images\n. Location (if you choose to allow it)\n. App usage analytics\n. We do not sell your personal data to third parties. For more details, refer to our Privacy Policy.",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF919191),
                                  ),
                                ),
                              ),
                            ],
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

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "You agree NOT to:\n. Use the app for illegal or harmful activities.\n. Upload content containing violence, hate, harassment, or explicit material.\n. Attempt to hack, reverse engineer, or misuse the app.\n. Impersonate other users or create fake content.",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF919191),
                                  ),
                                ),
                              ),
                            ],
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

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "All branding, design, content, and app features belong to Nufud.\nYou may not copy, reproduce, or redistribute any part of the app without permission.",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF919191),
                                  ),
                                ),
                              ),
                            ],
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

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Nufud is not responsible for:\n. Event cancellations, misinformation, or disputes between users\n. Damages resulting from the use of AI features\n. Loss of data or technical issues\n. You use the app at your own risk.",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF919191),
                                  ),
                                ),
                              ),
                            ],
                          ),

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

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "We may update these Terms from time to time.\nIf changes are made, we will notify users in the app.\nContinued use means you accept the updated Terms.",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF919191),
                                  ),
                                ),
                              ),
                            ],
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

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "If you have questions or concerns, please contact us:\nsupport@nafoud.app",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF919191),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(360.w, 42.h),
                              backgroundColor: Color(0xFF656A53),
                              foregroundColor: Color(0xFFF0F0EE),
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
