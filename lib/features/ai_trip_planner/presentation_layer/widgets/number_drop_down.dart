import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberDropdown extends StatelessWidget {
  final int value;
  final Function(int?) onChanged;
  final int maxNumber;

  const NumberDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.maxNumber = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: PopupMenuButton<int>(
        surfaceTintColor: Colors.white,
        offset: Offset(0, 50.h),
        constraints: BoxConstraints(
          maxHeight: 275.h,
          minWidth: (MediaQuery.of(context).size.width - 40.w) / 2.1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        itemBuilder: (context) => List.generate(maxNumber + 1, (index) => index)
            .map(
              (e) => PopupMenuItem<int>(
                value: e,
                child: Text("$e", style: GoogleFonts.cairo()),
              ),
            )
            .toList(),
        onSelected: onChanged,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$value",
                style: GoogleFonts.cairo(color: Colors.black, fontSize: 14.sp),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
