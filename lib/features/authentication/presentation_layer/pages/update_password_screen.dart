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

class UpdatePasswordScreen extends StatelessWidget {
  final String email;
  final String code;

  const UpdatePasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _newPasswordController =
        TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();
    final ValueNotifier<bool> _obscurePasswordNotifier = ValueNotifier(true);
    final ValueNotifier<bool> _obscurePasswordNotifierTwo = ValueNotifier(true);
    final ValueNotifier<String?> _errorNotifier = ValueNotifier(null);

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          _errorNotifier.value = null;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );

          Future.delayed(const Duration(milliseconds: 1500), () {
            if (context.mounted) {
              context.push(AppRoutes.signInScreen);
            }
          });
        }
        if (state is AuthenticationFailure) {
          _errorNotifier.value = state.message;
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
                            "Reset Password",
                            style: GoogleFonts.cairo(
                              fontSize: 25.9.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "Create a strong password to keep your password secure",
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            color: const Color(0xFF919191),
                          ),
                        ),

                        20.verticalSpace,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "New Password",
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
                              controller: _newPasswordController,
                              placeholder: "*********",
                              placeholderStyle: GoogleFonts.cairo(
                                fontSize: 18.sp,
                                color: const Color(0xFFB6B6B6),
                              ),
                              obscureText: isObscured,
                              obscuringCharacter: '*',
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
                                padding: EdgeInsets.only(right: 12.w),
                                child: GestureDetector(
                                  onTap: () {
                                    _obscurePasswordNotifier.value =
                                        !isObscured;
                                  },
                                  child: SvgPicture.asset(
                                    isObscured
                                        ? 'Assets/icons/eye_icon.svg'
                                        : 'Assets/icons/open_eye.svg',
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        22.verticalSpace,

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Confirm Password",
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: const Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        ValueListenableBuilder<bool>(
                          valueListenable: _obscurePasswordNotifierTwo,
                          builder: (context, isObscured, child) {
                            return CupertinoTextField(
                              controller: _confirmPasswordController,
                              placeholder: "*********",
                              placeholderStyle: GoogleFonts.cairo(
                                fontSize: 18.sp,
                                color: const Color(0xFFB6B6B6),
                              ),
                              obscureText: isObscured,
                              obscuringCharacter: '*',
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
                                padding: EdgeInsets.only(right: 12.w),
                                child: GestureDetector(
                                  onTap: () {
                                    _obscurePasswordNotifierTwo.value =
                                        !isObscured;
                                  },
                                  child: SvgPicture.asset(
                                    isObscured
                                        ? 'Assets/icons/eye_icon.svg'
                                        : 'Assets/icons/open_eye.svg',
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        ValueListenableBuilder<String?>(
                          valueListenable: _errorNotifier,
                          builder: (context, errorMsg, child) {
                            if (errorMsg == null &&
                                state is! AuthenticationFailure)
                              return const SizedBox.shrink();

                            String displayMessage =
                                errorMsg ??
                                (state is AuthenticationFailure
                                    ? state.message
                                    : '');

                            return Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  displayMessage,
                                  style: GoogleFonts.cairo(
                                    color: Colors.red,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        (state is AuthenticationFailure ||
                                _errorNotifier.value != null)
                            ? 170.verticalSpace
                            : 204.verticalSpace,

                        ElevatedButton(
                          onPressed: isAuthLoading
                              ? null
                              : () {
                                  _errorNotifier.value = null;

                                  final newPassword =
                                      _newPasswordController.text;
                                  final confirmPassword =
                                      _confirmPasswordController.text;

                                  if (newPassword.isEmpty ||
                                      confirmPassword.isEmpty) {
                                    _errorNotifier.value =
                                        "Please fill in both password fields.";
                                    return;
                                  }

                                  if (newPassword != confirmPassword) {
                                    _errorNotifier.value =
                                        "Passwords do not match.";
                                    return;
                                  }

                                  // Dispatch the final password update event
                                  context.read<AuthenticationBloc>().add(
                                    UpdatePasswordSubmitted(
                                      email: email,
                                      code: code,
                                      newPassword: newPassword,
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
                            "Save Password",
                            style: GoogleFonts.cairo(fontSize: 18.sp),
                          ),
                        ),

                        12.verticalSpace,
                        GestureDetector(
                          onTap: () => context.push(AppRoutes.signInScreen),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Remembered your password?",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xFF919191),
                                    fontSize: 15.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: " Sign In",
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
              if (isAuthLoading)
                Positioned.fill(
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(color: Colors.black.withOpacity(.2)),
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
