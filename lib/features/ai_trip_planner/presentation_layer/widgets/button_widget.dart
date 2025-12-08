import 'package:final_project/features/ai_trip_planner/presentation_layer/bloc/ai_trip_planner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationButtons extends StatelessWidget {
  final TripPlannerState state;
  final TripPlannerBloc bloc;

  const NavigationButtons({super.key, required this.state, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final currentStep = state.currentStep;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentStep > 0)
            TextButton(
              onPressed: () => bloc.add(TripStepChanged(currentStep - 1)),
              child: Text(
                "Back",
                style: GoogleFonts.cairo(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            const SizedBox(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF656A53),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            ),
            onPressed: () {
              if (currentStep == 0 &&
                  (state.preferences.destination == null ||
                      state.preferences.travelerType == null ||
                      state.preferences.dateRange == null)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Please select Destination, Traveler Type, and Dates.",
                    ),
                  ),
                );
                return;
              }

              if (currentStep == 1 && state.preferences.budget == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please select a Budget tier.")),
                );
                return;
              }

              if (currentStep < 2) {
                bloc.add(TripStepChanged(currentStep + 1));
              } else {
                bloc.add(TripPlanSubmitted());
              }
            },
            child: Row(
              children: [
                Text(
                  currentStep == 2 ? "Plan" : "Next",
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5.w),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
