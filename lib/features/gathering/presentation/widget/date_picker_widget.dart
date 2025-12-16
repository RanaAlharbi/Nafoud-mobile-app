import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../presentation/cubit/gathering_cubit.dart';
import 'picker_box.dart';

class DatePickerWidget extends StatelessWidget {
  final GatheringCubit cubit;

  const DatePickerWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),  // prevent past dates
          lastDate: DateTime(2035),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.khuzamaColor, // OK button and cancel
                  onPrimary: Colors.white,  // number color
                  onSurface: AppColors.primaryColor,  // days text color
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          cubit.setDate(picked);
        }
      },
      child: PickerBox(
        text: cubit.selectedDate == null
            ? "Select activity date"
            : DateFormat("yyyy-MM-dd").format(cubit.selectedDate!),
        icon: 'assets/icons/date.svg',
      ),
    );
  }
}

