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

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final ValueNotifier<bool> obscurePasswordNotifier = ValueNotifier(true);
    final ValueNotifier<bool> termsAcceptedNotifier = ValueNotifier(false);
    final ValueNotifier<String?> errorNotifier = ValueNotifier(null);

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          context.go(AppRoutes.otpScreen, extra: emailController.text);
        }
        if (state is AuthenticationFailure) {
          errorNotifier.value = state.message;
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
                            "Get Started",
                            style: GoogleFonts.cairo(
                              fontSize: 25.9.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "Start exploring places, culture, and hidden gems across the Kingdom",
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            color: const Color(0xFF919191),
                          ),
                        ),

                        20.verticalSpace,

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Name",
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CupertinoTextField(
                          controller: nameController,
                          placeholder: "Mohammed",
                          placeholderStyle: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            color: const Color(0xFFB6B6B6),
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
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SvgPicture.asset(
                              'assets/icons/profile_icon.svg',
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        ),

                        22.verticalSpace,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Email",
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CupertinoTextField(
                          controller: emailController,
                          placeholder: "Nafoud@Example.com",
                          placeholderStyle: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            color: const Color(0xFFB6B6B6),
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
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SvgPicture.asset(
                              'assets/icons/envelope_icon.svg',
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        ),

                        22.verticalSpace,

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Password",
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: obscurePasswordNotifier,
                          builder: (context, isObscured, child) {
                            return CupertinoTextField(
                              controller: passwordController,
                              placeholder: "*********",
                              placeholderStyle: GoogleFonts.cairo(
                                fontSize: 18.sp,
                                color: const Color(0xFFB6B6B6),
                              ),
                              obscureText: isObscured,
                              obscuringCharacter: '*',
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
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    obscurePasswordNotifier.value =
                                        !isObscured;
                                  },
                                  child: SvgPicture.asset(
                                    isObscured
                                        ? 'assets/icons/eye_icon.svg'
                                        : 'assets/icons/open_eye.svg',
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        19.verticalSpace,

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 3.h),
                              child: ValueListenableBuilder<bool>(
                                valueListenable: termsAcceptedNotifier,
                                builder: (context, isAccepted, child) {
                                  return GestureDetector(
                                    onTap: () {
                                      termsAcceptedNotifier.value =
                                          !isAccepted;
                                      if (errorNotifier.value ==
                                          "You must agree to the Terms & Conditions.") {
                                        errorNotifier.value = null;
                                      }
                                    },
                                    child: isAccepted
                                        ? SvgPicture.asset(
                                            'assets/icons/filled_checkbox.svg',
                                            width: 20.w,
                                            height: 20.h,
                                          )
                                        : Container(
                                            width: 20.w,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                              border: Border.all(
                                                color: const Color(0xFFB6B6B6),
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                  );
                                },
                              ),
                            ),
                            6.horizontalSpace,
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "I agree to the ",
                                      style: GoogleFonts.cairo(
                                        color: const Color(0xFF919191),
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Terms & Conditions",
                                      style: GoogleFonts.cairo(
                                        color: const Color(0xFF656A53),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: GoogleFonts.cairo(
                                        color: const Color(0xFF919191),
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: GoogleFonts.cairo(
                                        color: const Color(0xFF656A53),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        ValueListenableBuilder<String?>(
                          valueListenable: errorNotifier,
                          builder: (context, errorMsg, child) {
                            if (errorMsg == null) return SizedBox.shrink();
                            return Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  errorMsg,
                                  style: GoogleFonts.cairo(
                                    color: Colors.red,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        30.verticalSpace,

                        ElevatedButton(
                          onPressed: state is AuthenticationLoading
                              ? null
                              : () {
                                  if (!termsAcceptedNotifier.value) {
                                    errorNotifier.value =
                                        "You must agree to the Terms & Conditions.";
                                    return;
                                  }

                                  errorNotifier.value = null;

                                  context.read<AuthenticationBloc>().add(
                                    SignUpSubmitted(
                                      username: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
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
                            "Sign Up",
                            style: GoogleFonts.cairo(fontSize: 18.sp),
                          ),
                        ),

                        12.verticalSpace,
                        GestureDetector(
                          onTap: () {
                            context.go(AppRoutes.signInScreen);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Already have an account?",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xFF919191),
                                    fontSize: 15.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: " Login",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xFF656A53),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              if (state is AuthenticationLoading)
                Positioned.fill(
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: Colors.black.withValues(alpha: .2),
                        ),
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
