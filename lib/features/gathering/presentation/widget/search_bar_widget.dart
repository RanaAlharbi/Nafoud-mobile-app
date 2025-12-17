import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/gathering_cubit.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: CupertinoTextField(
        onChanged: (text) => context.read<GatheringCubit>().search(text),
        placeholder: "gathering.searchHere".tr(),
        placeholderStyle: GoogleFonts.cairo(
          color: Color(0xFFB6B6B6),
          height: 1.0.h,
          fontSize: 18.sp,
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        prefix: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(CupertinoIcons.search, color: Color(0xFF656A53)),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF656A53).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Color(0xFF656A53)),
        ),
      ),
    );
  }
}
