import 'package:final_project/features/ai_trip_planner/domain_layer/entity/ai_trip_entity.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/bloc/ai_trip_planner_bloc.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chip_group.dart';

class Step3TripVibe extends StatelessWidget {
  final TripEntity prefs;

  const Step3TripVibe({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TripPlannerBloc>();

    final interests = const [
      "Historical Sites",
      "Natural Places",
      "Local Restaurants",
      "Experiences",
      "Cafes",
      "Events",
      "Museums",
      "Shopping & Bazaars",
      "Adventure",
      "Beaches & Sea",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabel("Interests"),
        ChipGroup(
          options: interests,
          selectedItems: prefs.interests,
          isMulti: true,
          onSelect: (val) {
            List<String> list = List.from(prefs.interests);
            if (list.contains(val)) {
              list.remove(val);
            } else {
              list.add(val);
            }
            bloc.add(TripPreferencesUpdated(prefs.copy(interests: list)));
          },
        ),
      ],
    );
  }
}