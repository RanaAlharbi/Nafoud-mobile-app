import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChipGroup extends StatelessWidget {
  final List<String> options;
  final String? selectedItem;
  final List<String>? selectedItems;
  final bool isMulti;
  final Function(String) onSelect;

  const ChipGroup({
    super.key,
    required this.options,
    this.selectedItem,
    this.selectedItems,
    this.isMulti = false,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 10.h,
      children: options.map((opt) {
        bool isSelected =
            isMulti ? (selectedItems?.contains(opt) ?? false) : selectedItem == opt;

        return GestureDetector(
          onTap: () => onSelect(opt),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? const Color(0xFF656A53) : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: Text(
              opt,
              style: GoogleFonts.cairo(
                color: isSelected ? const Color(0xFF656A53) : Colors.grey,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}