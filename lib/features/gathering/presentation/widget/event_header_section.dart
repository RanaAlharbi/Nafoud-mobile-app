import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_state.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
              return Stack(
                fit: StackFit.expand,
                children: [
              
                  if (state is GatheringParticipantsLoading)
                    Container(color: Colors.grey.withValues(alpha: 0.3))
                  else
                    CachedNetworkImage(
                      imageUrl: event.imageUrl,
                      fit: BoxFit.cover,
                    ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      color: Colors.black.withValues(alpha: 0.40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        //title
                          if (state is GatheringParticipantsLoading)
                            Container(
                              width: 180.w,
                              height: 22.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            )
                          else
                            Text(
                              event.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          SizedBox(height: 10.h),

                       //profile - categories
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                           
                              if (state is GatheringParticipantsLoading)
                                Row(
                                  children: [
                                    Container(
                                      width: 35.w,
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withValues(alpha: 0.3),
                                      ),
                                    ),
                                    8.horizontalSpace,
                                    Container(
                                      width: 35.w,
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withValues(alpha: 0.3),
                                      ),
                                    ),
                                   8.horizontalSpace,
                                    Container(
                                      width: 35.w,
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withValues(alpha: 0.3),
                                      ),
                                    ),
                                  ],
                                )
                              else if (state is GatheringParticipantsLoaded &&
                                  state.avatars.isNotEmpty)
                                SizedBox(
                                  height: 45.h,
                                  width: 180.w,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      for (int i = 0;
                                          i < state.avatars.take(5).length;
                                          i++)
                                        Positioned(
                                          left: (i * 30).w,
                                          child: CircleAvatar(
                                            radius: 20.r,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 18.r,
                                              backgroundImage:
                                                  NetworkImage(state.avatars[i]),
                                            ),
                                          ),
                                        ),

                                      if (state.avatars.length > 5)
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
                                              "+${state.avatars.length - 5}",
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
                                )
                              else
                                SizedBox(height: 1.h),

                            
                              if (state is GatheringParticipantsLoading)
                                Container(
                                  width: 80.w,
                                  height: 22.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                )
                              else
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
                                    color: Colors.black.withValues(alpha: 0.1),
                                  ),
                                  child: Text(
                                    event.category,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
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
