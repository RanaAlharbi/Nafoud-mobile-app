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
        );
        if (picked != null) cubit.setTime(picked);
      },
      child: PickerBox(
        text: cubit.selectedTime == null
            ? "Select activity time"
            : cubit.selectedTime!.format(context),
        icon: "assets/icons/clock.svg"
      ),
    );
  }
}
