import 'dart:ui';
import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/authentication/presentation_layer/bloc/authentication_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jumping_dot/jumping_dot.dart';

class OTPScreen extends StatelessWidget {
  final String email;

  const OTPScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final int _otpLength = 6;
    final List<FocusNode> _focusNodes = List.generate(
      6,
      (index) => FocusNode(),
    );
    final List<TextEditingController> _otpControllers = List.generate(
      6,
      (index) => TextEditingController(),
    );

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              context.go(AppRoutes.signInScreen);
            }
          });
        }
      },
      builder: (context, state) {
        return CupertinoPageScaffold(
          backgroundColor: const Color(0xFFF1F1F1),
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
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "Enter the 6-digit code we sent to your email",
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            color: const Color(0xFF919191),
                          ),
                        ),

                        32.verticalSpace,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(_otpLength, (index) {
                            return SizedBox(
                              width: 52.w,
                              height: 62.h,
                              child: CupertinoTextField(
                                controller: _otpControllers[index],
                                focusNode: _focusNodes[index],
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cairo(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: const Color(0xFFB6B6B6),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(9.r),
                                ),
                                onChanged: (value) {
                                  // 1. Focus Logic
                                  if (value.isNotEmpty) {
                                    if (index < _otpLength - 1) {
                                      _focusNodes[index + 1].requestFocus();
                                    } else {
                                      _focusNodes[index].unfocus();
                                    }
                                  } else if (value.isEmpty && index > 0) {
                                    _focusNodes[index - 1].requestFocus();
                                  }

                                  final code = _otpControllers
                                      .map((e) => e.text)
                                      .join();
                                  if (code.length == 6) {
                                    context.read<AuthenticationBloc>().add(
                                      VerifyEmailSubmitted(
                                        email: email,
                                        otp: code,
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          }),
                        ),

                        20.verticalSpace,

                        if (state is AuthenticationLoading)
                          Positioned.fill(
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 5,
                                    sigmaY: 5,
                                  ),
                                  child: Container(
                                    color: Colors.black.withValues(alpha: .2),
                                  ),
                                ),
                                Center(
                                  child: JumpingDots(
                                    color: Color(0xFF656A53),
                                    radius: 10,
                                    numberOfDots: 3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (state is AuthenticationFailure)
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        if (state is AuthenticationSuccess)
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),

                        SizedBox(height: 20.h),

                        170.verticalSpace,

                        Text(
                          "The timer will be here",
                          style: GoogleFonts.cairo(
                            color: const Color(0xFF919191),
                            fontSize: 16.sp,
                          ),
                        ),

                        250.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
