import 'package:final_project/features/ai_trip_planner/presentation_layer/bloc/ai_trip_planner_bloc.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/button_widget.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/llm_chatview.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/step_one_trip_information.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/step_three_trip_vibe.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/step_two_trip_assitance.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/stepper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return BlocConsumer<TripPlannerBloc, TripPlannerState>(
        listener: (context, state) {
          if (state.status == TripStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("An error occurred during planning."),
              ),
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<TripPlannerBloc>();
          final currentStep = state.currentStep;

          if (state.status == TripStatus.loading) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(color: Color(0xFF656A53)),
              ),
            );
          }

          if (state.status == TripStatus.success) {
            return LlmChatView(result: state.aiResponse);
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Murshid",
                style: GoogleFonts.cairo(
                  color: const Color(0xFF3D4032),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Padding(
                padding: EdgeInsets.all(12.w),
                child: const Icon(Icons.arrow_back, color: Color(0xFF3D4032)),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: const Icon(Icons.menu, color: Color(0xFF3D4032)),
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF656A53),
                          size: 24,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Plan My Trip",
                          style: GoogleFonts.cairo(
                            color: const Color(0xFF656A53),
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    CustomStepper(currentStep: currentStep),
                    SizedBox(height: 25.h),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (currentStep == 0)
                              Step1TripInformation(prefs: state.preferences),
                            if (currentStep == 1)
                              Step2TripAssistance(prefs: state.preferences),
                            if (currentStep == 2)
                              Step3TripVibe(prefs: state.preferences),
                          ],
                        ),
                      ),
                    ),

                    NavigationButtons(state: state, bloc: bloc),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
