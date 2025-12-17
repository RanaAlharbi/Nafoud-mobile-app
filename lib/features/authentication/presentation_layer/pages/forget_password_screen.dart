import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
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

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          context.push(
            AppRoutes.otpScreen,
            extra: {'email': _emailController.text, 'type': 'reset'},
          );
        }
      },
      builder: (context, state) {
        final isAuthLoading = state is AuthenticationLoading;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textDirection: .ltr,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.pop();
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

                        58.83.verticalSpace,

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "forgetPassword.resetPassword".tr(),
                            style: GoogleFonts.cairo(
                              fontSize: 25.9.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "forgetPassword.resetCode".tr(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: const Color(0xFF919191),
                            ),
                          ),
                        ),

                        20.verticalSpace,
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "forgetPassword.email".tr(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CupertinoTextField(
                          controller: _emailController,
                          placeholder: "Nafoud@Example.com",
                          placeholderStyle: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            color: const Color(0xFFB6B6B6),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color(0xFFB6B6B6),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(9.r),
                          ),
                          suffix: Padding(
                            padding: EdgeInsetsDirectional.only(end: 12.w),
                            child: SvgPicture.asset(
                              'assets/icons/envelope_icon.svg',
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        ),

                        if (state is AuthenticationFailure)
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                state.message,
                                style: GoogleFonts.cairo(
                                  color: Colors.red,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        (state is AuthenticationFailure)
                            ? 170.verticalSpace
                            : 204.verticalSpace,

                        259.verticalSpace,
                        ElevatedButton(
                          onPressed: isAuthLoading
                              ? null
                              : () {
                                  if (_emailController.text.isNotEmpty) {
                                    context.read<AuthenticationBloc>().add(
                                      ResetPasswordEmailRequested(
                                        email: _emailController.text,
                                      ),
                                    );
                                  }
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
                            "forgetPassword.otp".tr(),
                            style: GoogleFonts.cairo(fontSize: 18.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isAuthLoading)
                Positioned.fill(
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(color: Colors.black.withValues(alpha: .2)),
                      ),
                      Center(
                        child: JumpingDots(
                          color: const Color(0xFF656A53),
                          radius: 10,
                          numberOfDots: 3,
                          animationDuration: const Duration(milliseconds: 200),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
