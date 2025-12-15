import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class EventHeaderSection extends StatelessWidget {
  final GatheringEntity event;
  const EventHeaderSection({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox(
          height: 361.h,
          child: BlocBuilder<GatheringCubit, GatheringState>(
            builder: (_, state) {
              final cubit = context.read<GatheringCubit>();

              final avatars = (state is GatheringParticipantsLoaded)
                  ? state.avatars
                  : cubit.lastAvatars;

              final bool noAvatars = avatars.isEmpty;

              return Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: event.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(color: Colors.white),
                    ),
                    errorWidget: (_, _, _) => Container(
                      color: Colors.grey,
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 120,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      color: Colors.black.withValues(alpha: 0.50),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          /// if no avatar yet
                          if (noAvatars)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    event.title,
                                    style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xff656A53),
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Colors.black.withValues(alpha: 0.15),
                                  ),
                                  child: Text(
                                    event.category,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          /// avatars
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 45.h,
                                  width: 180.w,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      for (
                                        int i = 0;
                                        i < avatars.take(5).length;
                                        i++
                                      )
                                        Positioned(
                                          left: (i * 30).w,
                                          child: CircleAvatar(
                                            radius: 20.r,
                                            backgroundColor: Colors.white,
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: avatars[i],
                                                fit: BoxFit.cover,
                                                width: 40.r,
                                                height: 40.r,

                                                /// shimmer
                                                placeholder: (_, _) =>
                                                    Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey.shade300,
                                                      highlightColor:
                                                          Colors.grey.shade100,
                                                      child: Container(
                                                        width: 40.r,
                                                        height: 40.r,
                                                        decoration:
                                                            const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                      ),
                                                    ),

                                                errorWidget: (_, _, _) =>
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                            color: Colors.grey,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                      child: const Icon(
                                                        Icons.error,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),

                                      if (avatars.length > 5)
                                        Positioned(
                                          left: (5 * 30).w,
                                          child: Container(
                                            width: 40.w,
                                            height: 40.h,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: Text(
                                              "+${avatars.length - 5}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xff656A53),
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Colors.black.withValues(alpha: 0.10),
                                  ),
                                  child: Text(
                                    event.category,
                                    style: GoogleFonts.cairo(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
