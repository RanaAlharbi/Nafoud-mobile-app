import 'package:final_project/features/ai_trip_planner/domain_layer/entity/ai_trip_entity.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/bloc/ai_trip_planner_bloc.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/city_drop_down.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/label_widget.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/number_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'chip_group.dart';

class Step1TripInformation extends StatelessWidget {
  final TripEntity prefs;

  const Step1TripInformation({super.key, required this.prefs});
  String _travelerTypeToUiString(TravelerType? type) {
    if (type == null) return '';
    return type.name[0].toUpperCase() + type.name.substring(1);
  }

  TravelerType _uiStringToTravelerType(String uiString) {
    return TravelerType.values.firstWhere(
      (e) => e.name.toLowerCase() == uiString.toLowerCase(),
      orElse: () => TravelerType.solo,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TripPlannerBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel("tripPlanner.step1.destination".tr()),
        CustomDropdown(
          hint: "tripPlanner.step1.destinationHint".tr(),
          value: prefs.destination,
          items: const ["Riyadh", "Jeddah", "Dammam", "Medina"],
          onChanged: (val) =>
              bloc.add(TripPreferencesUpdated(prefs.copy(destination: val))),
        ),

        19.verticalSpace,
        CustomLabel("tripPlanner.step1.whosGoing".tr()),
        ChipGroup(
          options: const ["Solo", "Partner", "Family", "Friends"],
          selectedItem: _travelerTypeToUiString(prefs.travelerType),
          onSelect: (val) {
            final type = _uiStringToTravelerType(val);
            bloc.add(TripPreferencesUpdated(prefs.copy(travelerType: type)));
          },
        ),

        19.verticalSpace,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabel("tripPlanner.step1.adults".tr()),
                  NumberDropdown(
                    value: prefs.adults ?? 0,
                    onChanged: (val) => bloc.add(
                      TripPreferencesUpdated(prefs.copy(adults: val)),
                    ),
                  ),
                ],
              ),
            ),
            11.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabel("tripPlanner.step1.kids".tr()),
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

        19.verticalSpace,
        CustomLabel("tripPlanner.step1.travelDates".tr()),
        GestureDetector(
          onTap: () async {
            final picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
              builder: (context, child) => Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color(0xFF656A53),
                    // Text color inside the circles
                    onPrimary: Colors.white,
                    // Background of the calendar
                    surface: Colors.white,
                    onSurface: Colors.black,
                    secondaryContainer: Color(0xFFE2E4D9),
                    // Text color inside the range
                    onSecondaryContainer: Color(0xFF3D4032),
                  ),
                  textTheme: GoogleFonts.cairoTextTheme(
                    Theme.of(context).textTheme,
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
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  prefs.dateRange == null
                      ? "tripPlanner.step1.selectDates".tr()
                      : "${DateFormat('MMM dd').format(prefs.dateRange!.start)} - ${DateFormat('MMM dd').format(prefs.dateRange!.end)}",
                  style: GoogleFonts.cairo(
                    color: prefs.dateRange == null ? Colors.grey : Colors.black,
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/calendar_icon.svg',
                  height: 24.h,
                  width: 24.w,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
