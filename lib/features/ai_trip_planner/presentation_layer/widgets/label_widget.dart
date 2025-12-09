import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLabel extends StatelessWidget {
  final String text;
  const CustomLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: GoogleFonts.cairo(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3D4032),
          ),
        ),

        4.verticalSpace,
      ],
    );
  }
}
