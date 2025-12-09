import 'package:final_project/features/ai_trip_planner/domain_layer/entity/ai_trip_entity.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/bloc/ai_trip_planner_bloc.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/city_drop_down.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/label_widget.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/number_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'chip_group.dart';

class Step1TripInformation extends StatelessWidget {
  final TripEntity prefs;
  final String Function(TravelerType?) travelerTypeToUiString;
  final TravelerType Function(String) uiStringToTravelerType;

  const Step1TripInformation({
    super.key,
    required this.prefs,
    required this.travelerTypeToUiString,
    required this.uiStringToTravelerType,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TripPlannerBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabel("Destination"),
        CustomDropdown(
          hint: "Where do you want to go?",
          value: prefs.destination,
          items: const ["Riyadh", "Jeddah", "AlUla", "Dammam", "Abha"],
          onChanged: (val) =>
              bloc.add(TripPreferencesUpdated(prefs.copy(destination: val))),
        ),

        SizedBox(height: 15.h),
        const CustomLabel("Who's Going?"),
        ChipGroup(
          options: const ["Solo", "Partner", "Family", "Friends"],
          selectedItem: travelerTypeToUiString(prefs.travelerType),
          onSelect: (val) {
            final type = uiStringToTravelerType(val);
            bloc.add(TripPreferencesUpdated(prefs.copy(travelerType: type)));
          },
        ),

        SizedBox(height: 15.h),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomLabel("Adults"),
                  NumberDropdown(
                    value: prefs.adults ?? 1,
                    onChanged: (val) => bloc.add(
                      TripPreferencesUpdated(prefs.copy(adults: val)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomLabel("Kids"),
                  NumberDropdown(
                    value: prefs.kids ?? 0,
                    onChanged: (val) =>
                        bloc.add(TripPreferencesUpdated(prefs.copy(kids: val))),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 15.h),
        const CustomLabel("Travel Dates"),
        GestureDetector(
          onTap: () async {
            final picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
              builder: (ctx, child) => Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color(0xFF656A53),
                  ),
                ),
                child: child!,
              ),
            );
            if (picked != null) {
              bloc.add(TripPreferencesUpdated(prefs.copy(dateRange: picked)));
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  prefs.dateRange == null
                      ? "Select your travel dates"
                      : "${DateFormat('MMM dd').format(prefs.dateRange!.start)} - ${DateFormat('MMM dd').format(prefs.dateRange!.end)}",
                  style: GoogleFonts.cairo(
                    color: prefs.dateRange == null
                        ? Colors.grey
                        : Colors.black87,
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
