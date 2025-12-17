import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../presentation/cubit/gathering_cubit.dart';

class CategoryChipsAdd extends StatelessWidget {
  final GatheringCubit cubit;

  const CategoryChipsAdd({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: cubit.categories.where((c) => c != "gathering.all".tr()).map((cat) {
        final isSelected = cubit.selectedCategory == cat;
        return ChoiceChip(
          showCheckmark: false,
          padding:  EdgeInsets.symmetric(horizontal: 12.h, vertical: 5.h),
          label: Text(cat),
          selected: isSelected,
          selectedColor: const Color(0xFF656A53),
          backgroundColor: Colors.white,
          onSelected: (_) => cubit.setCategory(cat),
          labelStyle: GoogleFonts.cairo(
            fontSize: 18,
            color: isSelected ? Colors.white : const Color(0xFF656A53),
          ),
        );
      }).toList(),
    );
  }
}
