import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.025,
  );

  static TextStyle splashScreenText = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.025,
    color: AppColors.splashScreenText,
  );

  static TextStyle logInSignUpTitle = GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteText,
  );

  static TextStyle forgotPassOTPVerifyTitle = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteText,
  );

  static TextStyle subTitle = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteText,
  );

  static TextStyle inputFieldText = GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteText.withValues(alpha: 0.5),
  );

  static TextStyle forgotPasswordText = GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.yellowText,
  );
}
