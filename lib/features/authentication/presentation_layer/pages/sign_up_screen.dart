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

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final ValueNotifier<bool> _obscurePasswordNotifier = ValueNotifier(true);
    final ValueNotifier<bool> _termsAcceptedNotifier = ValueNotifier(false);
    final ValueNotifier<String?> _errorNotifier = ValueNotifier(null);

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          context.push(
            AppRoutes.otpScreen,
            extra: {'email': _emailController.text, 'type': 'signup'},
          );
        }
        if (state is AuthenticationFailure) {
          _errorNotifier.value = state.message;
        }
      },
      builder: (context, state) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            automaticallyImplyLeading: false,
          ),
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
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(
                            'assets/logo/NafoudLogo.svg',
                            width: 67.87.w,
                            height: 69.17.h,
                          ),
                        ),

                        58.83.verticalSpace,

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "signUp.getStarted".tr(),
                            style: GoogleFonts.cairo(
                              fontSize: 25.9.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "signUp.subtitle".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            color: const Color(0xFF919191),
                          ),
                        ),

                        20.verticalSpace,

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "signUp.name".tr(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CupertinoTextField(
                          controller: _nameController,
                          placeholder: "signUp.namePlaceholder".tr(),
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
                            padding: const EdgeInsetsDirectional.only(end: 8.0),
                            child: SvgPicture.asset(
                              'assets/icons/profile_icon.svg',
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        ),

                        22.verticalSpace,
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "signUp.email".tr(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CupertinoTextField(
                          controller: _emailController,
                          placeholder: "signUp.emailPlaceholder".tr(),
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
                            padding: const EdgeInsetsDirectional.only(end: 8.0),
                            child: SvgPicture.asset(
                              'assets/icons/envelope_icon.svg',
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        ),

                        22.verticalSpace,

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "signUp.password".tr(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _obscurePasswordNotifier,
                          builder: (context, isObscured, child) {
                            return CupertinoTextField(
                              controller: _passwordController,
                              placeholder: "signUp.passwordPlaceholder".tr(),
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
                                padding: const EdgeInsetsDirectional.only(end: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _obscurePasswordNotifier.value =
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
                                valueListenable: _termsAcceptedNotifier,
                                builder: (context, isAccepted, child) {
                                  return GestureDetector(
                                    onTap: () {
                                      _termsAcceptedNotifier.value =
                                          !isAccepted;
                                      if (_errorNotifier.value ==
                                          "signUp.mustAgreeToTerms".tr()) {
                                        _errorNotifier.value = null;
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
                              child: GestureDetector(
                                onTap: () {
                                  context.push('/terms-and-conditions');
                                },
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "signUp.agreeToThe".tr(),
                                        style: GoogleFonts.cairo(
                                          color: const Color(0xFF919191),
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "signUp.termsAndConditions".tr(),
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
                            ),
                          ],
                        ),

                        ValueListenableBuilder<String?>(
                          valueListenable: _errorNotifier,
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
                                  if (!_termsAcceptedNotifier.value) {
                                    _errorNotifier.value =
                                        "signUp.mustAgreeToTerms".tr();
                                    return;
                                  }

                                  _errorNotifier.value = null;

                                  context.read<AuthenticationBloc>().add(
                                    SignUpSubmitted(
                                      username: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
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
                            "signUp.signUpButton".tr(),
                            style: GoogleFonts.cairo(fontSize: 18.sp),
                          ),
                        ),

                        12.verticalSpace,
                        GestureDetector(
                          onTap: () {
                            context.push(AppRoutes.signInScreen);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "signUp.alreadyHaveAccount".tr(),
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xFF919191),
                                    fontSize: 15.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: " ${"signUp.login".tr()}",
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
