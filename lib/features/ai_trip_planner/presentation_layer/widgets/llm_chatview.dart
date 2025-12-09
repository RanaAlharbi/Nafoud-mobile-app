import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LlmChatView extends StatelessWidget {
  final String? result;

  const LlmChatView({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SelectableText(
                  result ?? "The AI plan failed to load.",
                  style: GoogleFonts.cairo(fontSize: 14.sp, height: 1.6),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Ask anything...",
                  suffixIcon: const Icon(Icons.send, color: Color(0xFF656A53)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
