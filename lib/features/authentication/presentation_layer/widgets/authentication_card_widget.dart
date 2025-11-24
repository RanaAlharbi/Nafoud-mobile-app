import 'dart:ui';
import 'package:final_project/core/app_theme/app_text/app_text.dart';
import 'package:final_project/core/shared/Widgets/custom_button_widget.dart';
import 'package:final_project/features/authentication/presentation_layer/widgets/bottom_rich_text_widget.dart';
import 'package:final_project/features/authentication/presentation_layer/widgets/input_text_field.dart';
import 'package:flutter/material.dart';

class CustomAuthenticationCardWidget extends StatelessWidget {
  // Top
  final String title;
  final String subtitle;
  // Sizes
  final double cardWidth;
  final double cardHeight;

  // Which fields to show
  final bool showUsername;
  final bool showPassword;
  final bool showConfirmPassword;
  final bool showEmail;

  final TextEditingController? usernameController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;
  final TextEditingController? resetCodeController;

  final bool hasForgotPassword;
  final VoidCallback? onForgotPasswordTap;

  // Bottom text
  final bool hasBottomText;
  final List<TextPart>? bottomRichText;
  final VoidCallback? onBottomTextTap;

  final TextStyle? titleTextStyle;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const CustomAuthenticationCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.cardWidth,
    required this.cardHeight,
    required this.showUsername,
    required this.showPassword,
    required this.showEmail,
    required this.hasForgotPassword,
    required this.hasBottomText,
    this.onBottomTextTap,
    this.onForgotPasswordTap,
    required this.titleTextStyle,
    this.bottomRichText,
    required this.buttonText,
    required this.onButtonPressed,
    required this.showConfirmPassword,
    this.usernameController,
    this.emailController,
    this.passwordController,
    this.confirmPasswordController,
    this.resetCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 400),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                width: cardWidth,
                height: cardHeight,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.5),
                      Colors.white.withValues(alpha: 0.2),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(title, style: titleTextStyle),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: AppText.subTitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    if (showUsername)
                      CustomInputFields(
                        inputLabel: 'Username',
                        iconPath:
                            'Assets/Images/Icons/Input_Fields/usernameIcon.svg',
                        isObscure: false,
                        controller: usernameController,
                      ),
                    if (showUsername) const SizedBox(height: 12),

                    if (showEmail)
                      CustomInputFields(
                        inputLabel: 'Email',
                        iconPath:
                            'Assets/Images/Icons/Input_Fields/emailIcon.svg',
                        isObscure: false,
                        controller: emailController,
                      ),
                    if (showEmail) const SizedBox(height: 12),

                    if (showPassword)
                      CustomInputFields(
                        inputLabel: 'Password',
                        iconPath:
                            'Assets/Images/Icons/Input_Fields/lockIcon.svg',
                        isObscure: true,
                        controller: passwordController,
                      ),
                    if (showPassword) const SizedBox(height: 16),

                    if (showConfirmPassword)
                      CustomInputFields(
                        inputLabel: 'Confirm Password',
                        iconPath:
                            'Assets/Images/Icons/Input_Fields/lockIcon.svg',
                        isObscure: true,
                        controller: confirmPasswordController,
                      ),

                    if (hasForgotPassword)
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: onForgotPasswordTap,
                          child: Text(
                            'Forgot Password?',
                            style: AppText.forgotPasswordText,
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    CustomButtonWidget(
                      buttonWidth: 300,
                      buttonHeight: 40,
                      onPressed: onButtonPressed,
                      text: buttonText,
                    ),

                    if (hasBottomText && bottomRichText != null)
                      Center(
                        child: GestureDetector(
                          onTap: onBottomTextTap,
                          child: BottomRichTextWidget(
                            fullSentence: bottomRichText!,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
