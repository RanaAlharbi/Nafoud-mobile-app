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

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final ValueNotifier<bool> _obscurePasswordNotifier = ValueNotifier(true);
    final ValueNotifier<bool> _rememberMeNotifier = ValueNotifier(false);

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          context.push(AppRoutes.navigationScreen);
        }
      },
      builder: (context, state) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            automaticallyImplyLeading: false,
          ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                            "signIn.welcomeBack".tr(),
                            style: GoogleFonts.cairo(
                              fontSize: 25.9.sp,
                              color: Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "signIn.subtitle".tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            color: Color(0xFF919191),
                          ),
                        ),

                        20.verticalSpace,
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "signIn.email".tr(),
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CupertinoTextField(
                          controller: _emailController,
                          placeholder: "signIn.emailPlaceholder".tr(),
                          textAlignVertical: TextAlignVertical.center,
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
                            padding: EdgeInsetsDirectional.only(end: 12.w),
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
                            "signIn.password".tr(),
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
                              textAlignVertical: TextAlignVertical.center,
                              controller: _passwordController,
                              placeholder: "signIn.passwordPlaceholder".tr(),
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
                                padding: EdgeInsetsDirectional.only(end: 12.w),
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
                        13.verticalSpace,
                        Row(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: _rememberMeNotifier,
                              builder: (context, isRemembered, child) {
                                return GestureDetector(
                                  onTap: () {
                                    _rememberMeNotifier.value = !isRemembered;
                                  },
                                  child: Container(
                                    width: 20.w,
                                    height: 20.h,
                                    child: isRemembered
                                        ? SvgPicture.asset(
                                            'assets/icons/filled_checkbox.svg',
                                            fit: BoxFit.contain,
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xFFB6B6B6),
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                            6.horizontalSpace,
                            Text(
                              "signIn.rememberMe".tr(),
                              style: GoogleFonts.cairo(
                                fontSize: 15.sp,
                                color: Color(0xFF919191),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () =>
                                  context.push(AppRoutes.forgotPasswordScreen),
                              child: Text(
                                "signIn.forgetPassword".tr(),
                                style: GoogleFonts.cairo(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF656A53),
                                ),
                              ),
                            ),
                          ],
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

                        ElevatedButton(
                          onPressed: state is AuthenticationLoading
                              ? null
                              : () {
                                  context.read<AuthenticationBloc>().add(
                                    SignInSubmitted(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      rememberMe: _rememberMeNotifier.value,
                                    ),
                                  );
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
                            "signIn.login".tr(),
                            style: GoogleFonts.cairo(fontSize: 18.sp),
                          ),
                        ),

                        GestureDetector(
                          onTap: () => context.push(AppRoutes.signUpScreen),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "signIn.dontHaveAccount".tr(),
                                  style: GoogleFonts.cairo(
                                    color: Color(0xFF919191),
                                    fontSize: 15.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: " ${"signIn.signUp".tr()}",
                                  style: GoogleFonts.cairo(
                                    color: Color(0xFF656A53),
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
                          color: Color(0xFF656A53),
                          radius: 10,
                          numberOfDots: 3,
                          animationDuration: Duration(milliseconds: 200),
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
