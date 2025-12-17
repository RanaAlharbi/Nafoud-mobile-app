import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationLandingScreen extends StatelessWidget {
  const AuthenticationLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFF1F1F1),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/authentication/BackgroundLetters.svg',
              width: 419.w,
              height: 774.h,
              fit: BoxFit.contain,
            ),
          ),

          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                children: [
                  115.verticalSpace,
                  SvgPicture.asset(
                    'assets/logo/NafoudLogo.svg',
                    width: 267.87.w,
                    height: 273.h,
                  ),

                  81.verticalSpace,

                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "authLanding.title".tr(),
                      style: GoogleFonts.cairo(
                        fontSize: 25.9.sp,
                        color: Color(0xFF3D4032),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Text(
                    "authLanding.subtitle".tr(),
                    style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      color: Color(0xFF919191),
                    ),
                  ),

                  143.verticalSpace,
                  ElevatedButton(
                    onPressed: () {
                      context.push(AppRoutes.signInScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(360.w, 42.h),
                      backgroundColor: Color(0xFF656A53),
                      foregroundColor: Color(0xFFF0F0EE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "authLanding.login".tr(),
                      style: GoogleFonts.cairo(
                        // color: Color(0xFFF0F0EE),
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  12.verticalSpace,
                  ElevatedButton(
                    onPressed: () {
                      context.push(AppRoutes.signUpScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(360.w, 42.h),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Color(0xFF656A53),
                      side: BorderSide(color: Color(0xFF656A53)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "authLanding.createAccount".tr(),
                      style: GoogleFonts.cairo(
                        // color: Color(0xFFF0F0EE),
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
