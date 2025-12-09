import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;

  const CustomStepper({super.key, required this.currentStep});

  Widget _dot(int index, int currentStep) {
    bool isActive = index <= currentStep;
    final color = isActive ? const Color(0xFF656A53) : Colors.grey.shade300;

    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: Text(
          "${index + 1}",
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
      ),
    );
  }

  Widget _line(int index, int currentStep) {
    final color = index < currentStep
        ? const Color(0xFF656A53)
        : Colors.grey.shade300;

    return Expanded(
      child: Container(height: 2.h, color: color),
    );
  }

  Widget _stepText(String text, int index, int currentStep, TextAlign align) {
    final color = index == currentStep ? const Color(0xFF656A53) : Colors.grey;

    return SizedBox(
      width: 100.w,
      child: Text(
        text,
        textAlign: align,
        style: GoogleFonts.cairo(
          fontSize: 11.sp,
          color: color,
          fontWeight: index == currentStep
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _dot(0, currentStep),
            _line(0, currentStep),
            _dot(1, currentStep),
            _line(1, currentStep),
            _dot(2, currentStep),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _stepText("Trip Information", 0, currentStep, TextAlign.left),
            _stepText("Trip Assistance", 1, currentStep, TextAlign.center),
            _stepText("Trip Vibe", 2, currentStep, TextAlign.right),
          ],
        ),
      ],
    );
  }
}
