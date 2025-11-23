import 'package:final_project/core/app_theme/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInputFields extends StatelessWidget {
  final String inputLabel;
  final String iconPath;
  final bool isObscure;
  final TextEditingController? controller;

  const CustomInputFields({
    super.key,
    required this.inputLabel,
    required this.iconPath,
    required this.isObscure,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.32),
          width: 1,
        ),
      ),

      child: Row(
        children: [
          SvgPicture.asset(iconPath),

          SizedBox(width: 12),

          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isObscure,
              decoration: InputDecoration(
                hintText: inputLabel,
                hintStyle: AppText.inputFieldText,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
