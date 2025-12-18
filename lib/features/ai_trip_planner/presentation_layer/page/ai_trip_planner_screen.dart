import 'dart:ui';
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
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:easy_localization/easy_localization.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripPlannerBloc, TripPlannerState>(
      listener: (context, state) {
        if (state.status == TripStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("tripPlanner.error".tr())),
          );
        }
      },
      builder: (context, state) {
        // If successful, return the LLM widget with the response
        if (state.status == TripStatus.success && state.aiProvider != null) {
          return LlmWidget(provider: state.aiProvider!);
        }

        // Return stepper using stack
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('tripPlanner.murshid'.tr()),
            titleTextStyle: GoogleFonts.cairo(
              color: const Color(0xff3D4032),
              fontSize: 25.9.sp,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/location_icon.svg'),
                          10.horizontalSpace,
                          Text(
                            "murshid.plan_trip".tr(),
                            style: GoogleFonts.cairo(
                              color: const Color(0xFF656A53),
                              fontSize: 31.1.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      CustomStepper(currentStep: state.currentStep),
                      25.verticalSpace,
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (state.currentStep == 0)
                                Step1TripInformation(prefs: state.preferences),
                              if (state.currentStep == 1)
                                Step2TripAssistance(prefs: state.preferences),
                              if (state.currentStep == 2)
                                Step3TripVibe(prefs: state.preferences),
                            ],
                          ),
                        ),
                      ),
                      NavigationButtons(
                        state: state,
                        bloc: context.read<TripPlannerBloc>(),
                      ),
                    ],
                  ),
                ),
              ),

              // If loading, display jumping dots 
              if (state.status == TripStatus.loading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Center(
                        child: JumpingDots(
                          color: const Color(0xFF656A53),
                          radius: 10,
                          numberOfDots: 3,
                          animationDuration: const Duration(milliseconds: 200),
                        ),
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
