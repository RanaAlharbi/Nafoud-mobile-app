import 'package:final_project/features/authentication/presentation_layer/widgets/otp_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int _otpLength = 6;
    List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
    List<TextEditingController> _otpController = List.generate(
      6,
      (index) => TextEditingController(),
    );

    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFF1F1F1),
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
                        'Assets/logo/NafoudLogo.svg',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_otpLength, (index) {
                        return SizedBox(
                          width: 52,
                          height: 62,
                          child: CupertinoTextField(
                            controller: _otpController[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            onChanged: (value) {
                              if (value.isNotEmpty && index < _otpLength - 1) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(_focusNodes[index + 1]);
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(_focusNodes[index - 1]);
                              }
                            },
                          ),
                        );
                      }),
                    ),

                    190.verticalSpace,
                    OtpWidget(),

                    250.verticalSpace,
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
