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
          firstDate: DateTime(2020),
          lastDate: DateTime(2035),
        );
        if (picked != null) cubit.setDate(picked);
      },
      child: PickerBox(
        text: cubit.selectedDate == null
            ? "Select activity date"
            : DateFormat("yyyy-MM-dd").format(cubit.selectedDate!),
        icon: 'assets/icons/date.svg'
      ),
    );
  }
}
