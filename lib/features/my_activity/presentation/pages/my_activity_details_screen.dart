import 'package:final_project/core/shared/utils/share_utils.dart';
import 'package:final_project/features/my_activity/presentation/widgets/my_activity_event_header.dart';
import 'package:final_project/features/gathering/presentation/widget/event_info_section.dart';
import 'package:final_project/features/gathering/presentation/widget/event_map_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:final_project/features/my_activity/presentation/cubit/my_activity_cubit.dart';
import 'package:final_project/features/my_activity/presentation/cubit/my_activity_state.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';

class MyActivityDetailsScreen extends StatelessWidget {
  final GatheringEntity event;
  const MyActivityDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> expanded = ValueNotifier(false);

    context.read<MyActivityCubit>().loadParticipants(event.id!);

    return BlocListener<MyActivityCubit, MyActivityState>(
      listener: (context, state) {
        if (state is MyActivityErrorState) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 28),
                  const SizedBox(width: 10),
                  Text(
                    "Error",
                    style: GoogleFonts.cairo(fontSize: 20, color: Colors.red),
                  ),
                ],
              ),
              content: Text(
                state.message,
                style: GoogleFonts.cairo(fontSize: 16),
              ),
              actions: [
                TextButton(
                  child: Text(
                    "DISMISS",
                    style: GoogleFonts.cairo(color: Colors.red, fontSize: 16),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        }
      },
      child: CupertinoPageScaffold(
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
            onPressed: () => Navigator.pop(context),
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
                MyActivityEventHeader(event: event),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: expanded,
                    builder: (_, isExpanded, _) {
                      final bool isLongText = event.description.length > 150;

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
                            maxLines: isLongText ? (isExpanded ? null : 3) : null,
                            overflow: isLongText
                                ? (isExpanded
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis)
                                : TextOverflow.visible,
                            style: GoogleFonts.cairo(
                              fontSize: 15.sp,
                              height: 1.4,
                              color: const Color(0xFF4D4D4D),
                            ),
                          ),
                          if (isLongText) 4.verticalSpace,
                          if (isLongText)
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
                          Divider(
                            color: const Color(0xffCFD1CA),
                            thickness: 1.h,
                          ),
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
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5B5F4B),
                    ),
                  ),
                ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: EventInfo(event: event),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: EventMapSection(event: event),
                ),
                30.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
