import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:final_project/core/app_theme/app_sizes/app_sizes.dart';
import 'package:final_project/core/app_theme/app_text/app_text.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final double buttonWidth;
  final double buttonHeight;
  final VoidCallback onPressed;
  final String text;

  const CustomButtonWidget({
    super.key,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonFillColor,
        foregroundColor: AppColors.buttonForegroundColor,
        shadowColor: AppColors.shadowColor.withValues(
          alpha: AppSizes.buttonShadowOpacity,
        ),
        elevation: AppSizes.buttonShadowElevation,
        fixedSize: Size(buttonWidth, buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
          side: BorderSide(
            color: AppColors.buttonBorderColor,
            width: AppSizes.buttonBorderWeight,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: AppText.buttonText),
    );
  }
}
