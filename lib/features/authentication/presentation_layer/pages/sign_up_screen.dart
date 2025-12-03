import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/authentication/presentation_layer/bloc/authentication_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          context.go(AppRoutes.otpScreen);
        } else if (state is AuthenticationFailure) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(state.message),
              content: Text(state.message),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("OK"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
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
                            "Get Started",
                            style: GoogleFonts.cairo(
                              fontSize: 25.9.sp,
                              color: Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "Start exploring places, culture, and hidden gems across the Kingdom",
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            color: Color(0xFF919191),
                          ),
                        ),

                        20.verticalSpace,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Name",
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                              color: Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CupertinoTextField(
                          controller: _nameController,
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
                          suffix: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: SvgPicture.asset(
                              'Assets/icons/profile_icon.svg',
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
                              color: Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CupertinoTextField(
                          controller: _emailController,
                          placeholder: "Nafoud@Example.com",
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
                          suffix: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: SvgPicture.asset(
                              'Assets/icons/envelope_icon.svg',
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
                              color: Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CupertinoTextField(
                          controller: _passwordController,
                          placeholder: "*********",
                          placeholderStyle: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            color: Color(0xFFB6B6B6),
                          ),
                          obscureText: true,
                          obscuringCharacter: '*',
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color(0xFFB6B6B6),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(9.r),
                          ),
                          suffix: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: SvgPicture.asset(
                              'Assets/icons/eye_icon.svg',
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        ),

                        19.verticalSpace,
                        Row(
                          children: [
                            Container(
                              width: 16.w,
                              height: 16.h,
                              child: CupertinoCheckbox(
                                value: rememberMe,
                                onChanged: (bool? newVal) {},
                                side: BorderSide(
                                  color: Color(0xFFB6B6B6),
                                  width: 1.5.w,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                            ),
                            6.horizontalSpace,
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: GoogleFonts.cairo(
                                      color: Color(0xFF919191),
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Terms & Conditions",
                                    style: GoogleFonts.cairo(
                                      color: Color(0xFF656A53),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  TextSpan(
                                    text: " and ",
                                    style: GoogleFonts.cairo(
                                      color: Color(0xFF919191),
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: GoogleFonts.cairo(
                                      color: Color(0xFF656A53),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        85.verticalSpace,

                        ElevatedButton(
                          onPressed: state is AuthenticationLoading
                              ? null
                              : () {
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
                            backgroundColor: Color(0xFF656A53),
                            foregroundColor: Color(0xFFF0F0EE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: state is AuthenticationLoading
                              ? SizedBox(
                                  height: 20.h,
                                  width: 20.h,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "Sign Up",
                                  style: GoogleFonts.cairo(
                                    // color: Color(0xFFF0F0EE),
                                    fontSize: 18.sp,
                                  ),
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
                                    color: Color(0xFF919191),
                                    fontSize: 15.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: " Login",
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
            ],
          ),
        );
      },
    );
  }
}
