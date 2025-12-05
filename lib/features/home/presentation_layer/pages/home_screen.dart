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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
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
                              IconButton(
                                onPressed: (){}, 
                                icon: SvgPicture.asset("./Assets/icons/Bell.svg")
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                
                // "Enjoy the moment with others" Section
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.primaryColor,
                  ),
                  child: Stack(
                    children: [
                      // Saudi Male on the home screen
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16.r),
                            bottomRight: Radius.circular(16.r),
                          ),
                          child: SvgPicture.asset(
                            './Assets/Images/home/saudi_male_template.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enjoy the moment with others!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(12.h),
                            Text(
                              'Got an event and looking for company?\nPost your announcement and let everyone join',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                height: 1.5,
                              ),
                            ),
                            Gap(20.h),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to post event screen
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, 
                                  vertical: 12.h
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                'Post Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                Gap(24.h),
                
                // Your Quick Guides Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Your Quick Guides',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                
                Gap(16.h),
                
                // Quick Guide Icons
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    scrollDirection: .vertical,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround, // temporary
                      children: [
                        buildQuickGuideItem(
                          icon: Icons.directions_bus,
                          label: 'Transport',
                          onTap: () {},
                        ),
                        buildQuickGuideItem(
                          icon: Icons.sim_card,
                          label: 'SIM Card',
                          onTap: () {},
                        ),
                        buildQuickGuideItem(
                          icon: Icons.emergency,
                          label: 'Emergency',
                          onTap: () {},
                        ),
                        buildQuickGuideItem(
                          icon: Icons.cloud,
                          label: 'Weather',
                          onTap: () {},
                        ),
                        buildQuickGuideItem(
                          icon: Icons.currency_exchange,
                          label: 'Currency',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                
                Gap(24.h),
                
                // Recommended Activities Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recommended Activities',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO
                        },
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Gap(8.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget buildQuickGuideItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 70.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.grey,
                size: 24.w,
              ),
            ),
            Gap(8.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
