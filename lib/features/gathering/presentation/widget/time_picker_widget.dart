import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import '../../presentation/cubit/gathering_cubit.dart';
import 'picker_box.dart';

class TimePickerWidget extends StatelessWidget {
  final GatheringCubit cubit;

  const TimePickerWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.primaryColor,
                  onPrimary: Colors.white,
                  onSurface: AppColors.khuzamaColor,
                ),

                timePickerTheme: const TimePickerThemeData(
                  dayPeriodColor: AppColors.khuzamaColor,
                  dayPeriodTextColor: Colors.white, //text of am - pm
                  dayPeriodShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) cubit.setTime(picked);
      },
      child: PickerBox(
        text: cubit.selectedTime == null
            ? "Select activity time"
            : cubit.selectedTime!.format(context),
        icon: "assets/icons/clock.svg",
      ),
    );
  }
}
