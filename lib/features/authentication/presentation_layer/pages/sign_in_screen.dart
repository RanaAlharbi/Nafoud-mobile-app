import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/authentication/presentation_layer/bloc/authentication_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    bool rememberMe = false;
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          context.go(AppRoutes.navigationScreen);
        } else if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
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
                            "Welcome Back!",
                            style: GoogleFonts.cairo(
                              fontSize: 25.9.sp,
                              color: Color(0xFF3D4032),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "Your journey across Saudi Arabia continues here",
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            color: Color(0xFF919191),
                          ),
                        ),

                        20.verticalSpace,
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
                          suffix: SvgPicture.asset(
                            'assets/icons/envelope_icon.svg',
                            width: 24.w,
                            height: 24.h,
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
                          suffix: SvgPicture.asset(
                            'assets/icons/eye_icon.svg',
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),

                        13.verticalSpace,
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
                            Text(
                              "Remember Me",
                              style: GoogleFonts.cairo(
                                fontSize: 15.sp,
                                color: Color(0xFF919191),
                              ),
                            ),
                            124.horizontalSpace,
                            Text(
                              "Forget Password?",
                              style: GoogleFonts.cairo(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF656A53),
                              ),
                            ),
                          ],
                        ),

                        204.verticalSpace,

                        ElevatedButton(
                          onPressed: state is AuthenticationLoading
                              ? null
                              : () {
                                  context.read<AuthenticationBloc>().add(
                                    SignInSubmitted(
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
                          child: Text(
                            "Login",
                            style: GoogleFonts.cairo(
                              // color: Color(0xFFF0F0EE),
                              fontSize: 18.sp,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () => context.go(AppRoutes.signUpScreen),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account?",
                                  style: GoogleFonts.cairo(
                                    color: Color(0xFF919191),
                                    fontSize: 15.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: " Sign Up",
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
