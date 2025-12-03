import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _otpController = TextEditingController();
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
                        "Verify Your Email Address",
                        style: GoogleFonts.cairo(
                          fontSize: 25.9.sp,
                          color: Color(0xFF3D4032),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Text(
                      "Enter the 6-digit code we sent to your email",
                      style: GoogleFonts.cairo(
                        fontSize: 18.sp,
                        color: Color(0xFF919191),
                      ),
                    ),

                    32.verticalSpace,
                    CupertinoTextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      placeholder: "Mohammed",
                      placeholderStyle: GoogleFonts.cairo(
                        fontSize: 18.sp,
                        color: Color(0xFFB6B6B6),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Color(0xFFB6B6B6),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(9.r),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
