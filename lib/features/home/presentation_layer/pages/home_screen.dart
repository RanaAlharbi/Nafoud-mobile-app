import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/events/presentation_layer/cubit/event_cubit.dart';
import 'package:final_project/features/events/domain_layer/usecase/events_usecase.dart';
import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:final_project/features/profile/presentation_layer/cubit/profile_cubit.dart';
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
          create: (_) => ProfileCubit(GetIt.I.get<ProfileUsecase>())..loadProfile(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Gap(10.h),
                BlocBuilder<ProfileCubit, ProfileState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    final profile = state is ProfileLoaded ? state.profile : null;

                    return Row(
                      children: [
                        // Image Area
                        CircleAvatar(
                          // Cover Image
                          backgroundColor: Color.fromRGBO(101, 106, 83, 1),
                          radius: 43.h,

                          // The image itself
                          child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(254, 254, 254, 1),
                            radius: 40.h,
                            backgroundImage: profile?.avatarUrl != null
                                ? NetworkImage(profile!.avatarUrl!)
                                : null,
                            child: profile?.avatarUrl == null
                                ? Icon(
                                    Icons.person,
                                    size: 40.h,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20.w)),
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            Row(
                              children: [
                                Text("Hello, "),
                                Text(
                                  profile?.fullName ?? "Guest",
                                  style: TextStyle(color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                            Text("What would you like to do today?"),
                          ],
                        ),
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
