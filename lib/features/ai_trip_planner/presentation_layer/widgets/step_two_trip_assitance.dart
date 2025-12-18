import 'package:final_project/features/ai_trip_planner/domain_layer/entity/ai_trip_entity.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/bloc/ai_trip_planner_bloc.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/widgets/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import 'chip_group.dart';

class Step2TripAssistance extends StatelessWidget {
  final TripEntity prefs;

  const Step2TripAssistance({super.key, required this.prefs});

  String _budgetToUiString(BudgetTier? tier) {
    if (tier == null) return '';
    switch (tier) {
      case BudgetTier.flexible:
        return 'Flexible';
      case BudgetTier.budget:
        return 'Budget \$';
      case BudgetTier.sensible:
        return 'Sensible \$\$';
      case BudgetTier.upscale:
        return 'Upscale \$\$\$';
      case BudgetTier.luxury:
        return 'Luxury \$\$\$\$';
    }
  }

  BudgetTier _uiStringToBudget(String uiString) {
    final cleanString = uiString.toLowerCase().replaceAll(RegExp(r'\s|\$'), '');
    return BudgetTier.values.firstWhere(
      (e) => e.name == cleanString,
      orElse: () => BudgetTier.flexible,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TripPlannerBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel("tripPlanner.step2.howCanHelp".tr()),
        ChipGroup(
          options: const ["Accommodation", "Activities", "Food"],
          selectedItems: prefs.assistanceNeeded,
          isMulti: true,
          onSelect: (val) {
            List<String> list = List.from(prefs.assistanceNeeded);
            if (list.contains(val)) {
              list.remove(val);
            } else {
              list.add(val);
            }
            bloc.add(
              TripPreferencesUpdated(prefs.copy(assistanceNeeded: list)),
            );
          },
        ),

        20.verticalSpace,
        CustomLabel("tripPlanner.step2.budget".tr()),
        ChipGroup(
          options: const [
            "Flexible",
            "Budget \$",
            "Sensible \$\$",
            "Upscale \$\$\$",
            "Luxury \$\$\$\$",
          ],
          selectedItem: _budgetToUiString(prefs.budget),
          onSelect: (val) {
            final budgetType = _uiStringToBudget(val);
            bloc.add(TripPreferencesUpdated(prefs.copy(budget: budgetType)));
          },
        ),
      ],
    );
  }
}
