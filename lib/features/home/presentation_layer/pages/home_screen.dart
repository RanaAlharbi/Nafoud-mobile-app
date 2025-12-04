import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/events/presentation_layer/cubit/event_cubit.dart';
import 'package:final_project/features/events/domain_layer/usecase/events_usecase.dart';
import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:final_project/features/home/presentation_layer/cubit/home_user_info_cubit.dart';
import 'package:final_project/features/profile/domain_layer/usecase/profile_usecase.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => EventCubit(getIt<EventsUsecase>())..loadedEvents(),
        ),
        BlocProvider(
          create: (_) =>
              HomeUserInfoCubit(GetIt.I.get<ProfileUsecase>())..loadUserInfo(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Gap(10.h),
                BlocBuilder<HomeUserInfoCubit, HomeUserInfoState>(
                  builder: (context, state) {
                    // Extract user info from loaded state, or use defaults
                    final String fullName = state is HomeUserInfoLoaded
                        ? state.fullName
                        : "Guest";
                    final String? avatarUrl = state is HomeUserInfoLoaded
                        ? state.avatarUrl
                        : null;

                    return Row(
                      spacing: 15.w,
                      children: [
                        // Image Area
                        CircleAvatar(
                          // Cover Image
                          backgroundColor: Color.fromRGBO(101, 106, 83, 1),
                          radius: 41.h,

                          // The image itself
                          child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(254, 254, 254, 1),
                            radius: 40.h,
                            backgroundImage: avatarUrl != null
                                ? NetworkImage(avatarUrl)
                                : null,
                            child: avatarUrl == null
                                ? Icon(
                                    Icons.person,
                                    size: 40.h,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(15.h),
                            Row(
                              children: [
                                Text(
                                  "Hello, ",
                                  style: TextStyle(fontSize: 20.w),
                                ),
                                Text(
                                  fullName,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Gap(10.h),
                            Text(
                              "What would you like to do today?",
                              style: TextStyle(fontSize: 15.h),
                            ),
                          ],
                        ),
                        IconButton(onPressed: (){}, icon: SvgPicture.asset("./Assets/icons/Bell.svg"))
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
