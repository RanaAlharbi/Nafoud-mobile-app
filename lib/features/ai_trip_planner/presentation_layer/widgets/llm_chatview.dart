import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/markdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                child: markdownCard(result ?? "The AI plan failed to load."),
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
