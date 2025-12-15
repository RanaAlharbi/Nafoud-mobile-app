import 'package:flutter/material.dart';
import '../../presentation/cubit/gathering_cubit.dart';

class CategoryChipsAdd extends StatelessWidget {
  final GatheringCubit cubit;

  const CategoryChipsAdd({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: cubit.categories.where((c) => c != "All").map((cat) {
        final isSelected = cubit.selectedCategory == cat;

        return ChoiceChip(
          label: Text(cat),
          selected: isSelected,
          selectedColor: const Color(0xFF656A53),
          backgroundColor: Colors.white,
          onSelected: (_) => cubit.setCategory(cat),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF656A53),
          ),
        );
      }).toList(),
    );
  }
}
