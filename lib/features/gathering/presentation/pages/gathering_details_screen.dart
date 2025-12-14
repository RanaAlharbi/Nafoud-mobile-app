import 'package:final_project/core/shared/utils/share_utils.dart';
import 'package:final_project/features/gathering/presentation/widget/event_header_section.dart';
import 'package:final_project/features/gathering/presentation/widget/event_info_section.dart';
import 'package:final_project/features/gathering/presentation/widget/event_map_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/gathering_cubit.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';

class GatheringDetailsScreen extends StatelessWidget {
  final GatheringEntity event;

  GatheringDetailsScreen({super.key, required this.event});

  // ValueNotifier for read more description
  final ValueNotifier<bool> expanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    context.read<GatheringCubit>().loadParticipants(event.id!);

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF0F0EE),

      navigationBar: CupertinoNavigationBar(
        middle: Text(
          event.category,
          style: GoogleFonts.cairo(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF3D4032),
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context, "refresh"),
          child: const Icon(
            CupertinoIcons.arrow_left,
            color: Color(0xFFB6B6B6),
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.share, color: Color(0xFFB6B6B6)),
          onPressed: () => ShareUtils.shareEvent(event),
        ),
      ),

      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 9.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventHeaderSection(event: event),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ValueListenableBuilder<bool>(
                  valueListenable: expanded,
                  builder: (_, isExpanded, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 23.h),

                        Text(
                          "About ${event.category}",
                          style: GoogleFonts.cairo(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF5B5F4B),
                          ),
                        ),

                        15.verticalSpace,
                        Text(
                          event.description,
                          maxLines: isExpanded ? null : 3,
                          overflow: isExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            height: 1.4,
                            fontWeight: .normal,
                            color: const Color(0xFF4D4D4D),
                          ),
                        ),

                        4.verticalSpace,

                        GestureDetector(
                          onTap: () => expanded.value = !expanded.value,
                          child: Row(
                            children: [
                              Text(
                                isExpanded ? "Read Less" : "Read More",
                                style: GoogleFonts.cairo(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF5B5F4B),
                                ),
                              ),
                              6.verticalSpace,
                              Icon(
                                isExpanded
                                    ? CupertinoIcons.chevron_up
                                    : CupertinoIcons.chevron_down,
                                size: 16.sp,
                                color: const Color(0xFF3D4032),
                              ),
                            ],
                          ),
                        ),

                        16.verticalSpace,

                        Divider(color: const Color(0xffCFD1CA), thickness: 1.h),

                        14.verticalSpace,
                      ],
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "Information",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: .bold,
                    color: const Color(0xFF5B5F4B),
                  ),
                ),
              ),

              16.verticalSpace,

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: EventInfo(event: event),
              ),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: EventMapSection(event: event),
              ),

              30.verticalSpace,

              Center(
                child: SizedBox(
                  width: 360.w,
                  height: 42.h,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero, 
                    color: const Color(0xFF656A53),
                    borderRadius: BorderRadius.circular(8.r),
                    onPressed: () =>
                        context.read<GatheringCubit>().joinEvent(event.id!),
                    child: Text(
                      "Joining",
                      style: GoogleFonts.cairo(
                        fontSize: 18.sp,
                         color: Colors.white,
                         fontWeight: .bold
                        ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
