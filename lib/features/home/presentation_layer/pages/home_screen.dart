import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/home/presentation_layer/widgets/build_quick_guide_item_widget.dart';
import 'package:final_project/features/home/presentation_layer/widgets/discover_widget.dart';
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
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '';

    final words = name.trim().split(' ').where((word) => word.isNotEmpty).toList();

    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();

    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

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
        backgroundColor: Color.fromRGBO(241,241,241, 1),
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
                              // Image Area (PFP)
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: avatarUrl != null
                                        ? const Color.fromRGBO(101, 106, 83, 1) // 656A53 hex
                                        : const Color.fromRGBO(194, 164, 128, 1),
                                    width: 2.5.w,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: const Color.fromRGBO(237, 234, 231, 1), // EDEAE7 hex
                                  radius: 40.h,

                                  // The image itself (PFP)
                                  child: avatarUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl: avatarUrl,
                                          imageBuilder: (context, imageProvider) => Container(
                                            width: 80.h,
                                            height: 80.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) => CircularProgressIndicator(
                                            strokeWidth: 2.w,
                                            color: const Color.fromRGBO(194, 164, 128, 1),
                                          ),
                                          errorWidget: (context, url, error) {
                                            final initials = _getInitials(fullName);
                                            return initials.isNotEmpty
                                                ? Text(
                                                    initials,
                                                    style: TextStyle(
                                                      color: const Color.fromRGBO(194, 164, 128, 1), // C2A480 hex
                                                      fontSize: 35.sp,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )
                                                : Icon(
                                                    Icons.person,
                                                    size: 40.h,
                                                    color: const Color.fromRGBO(194, 164, 128, 1),
                                                  );
                                          },
                                        )
                                      : _getInitials(fullName).isNotEmpty
                                          ? Text(
                                              _getInitials(fullName),
                                              style: TextStyle(
                                                color: const Color.fromRGBO(194, 164, 128, 1), // C2A480 hex
                                                fontSize: 35.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : Icon(
                                              Icons.person,
                                              size: 40.h,
                                              color: const Color.fromRGBO(194, 164, 128, 1),
                                            ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Gap(15.h),
                                    Row(
                                      children: [
                                        Text(
                                          "Hello, ",
                                          style: TextStyle(
                                            fontSize: 20.w,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            fullName,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 20.h,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(10.h),
                                    Text(
                                      "What would you like to do today?",
                                      style: TextStyle(
                                        fontSize: 10.h,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  "./assets/icons/Bell.svg",
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Gap(30.h),

                // "Enjoy the moment with others" Section
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Transparent Background
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.white,
                              Colors.transparent,
                            ],
                            stops: [0.65, 1],
                          ).createShader(bounds);
                        },
                        blendMode: .dstIn,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: AppColors.primaryColor,
                            border: Border.all(color: AppColors.khuzamaColor, width: 2),
                          ),
                          width: double.infinity,
                          height: 200.h,
                        ),
                      ),
                      // Content 
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enjoy the moment with others!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(12.h),
                            Text(
                              'Got an event and looking for company?\nPost your announcement and let everyone join',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                height: 2,
                              ),
                            ),
                            Gap(20.h),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    AppColors.khuzamaColor,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to post event screen
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: AppColors.khuzamaColor,
                                    shadowColor: Colors.transparent,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    minimumSize: Size(0, 33.h),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14.w,
                                      vertical: 0.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                  ),
                                  child: Text(
                                    'Post Now',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Saudi Male on the home screen
                      Positioned(
                        right: 0,
                        top: -64.h,
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.transparent,
                                Colors.white,
                              ],
                              stops: [0.2, 1],
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.dstIn,
                          child: Image.asset(
                            'assets/Images/home/saudi_male_template.png',
                            width: 230.w,
                            height: 300.h,
                            fit: BoxFit.contain,
                          ),
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
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                ),

                Gap(16.h),

                // Quick Guide Icons
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BuildQuickGuideItemWidget(
                          svgPath: './assets/icons/Tram.svg',
                          label: 'Transport',
                          onTap: () {
                            context.push(AppRoutes.transportScreen);
                          },
                        ),
                        BuildQuickGuideItemWidget(
                          svgPath: './assets/icons/SimCard.svg',
                          label: 'SIM Card',
                          onTap: () {
                            context.push(AppRoutes.simCardScreen);
                          },
                        ),
                        BuildQuickGuideItemWidget(
                          svgPath: './assets/icons/Emergency.svg',
                          label: 'Emergency',
                          onTap: () {
                            context.push(AppRoutes.emergencyScreen);
                          },
                        ),
                        BuildQuickGuideItemWidget(
                          svgPath: './assets/icons/Cloud.svg',
                          label: 'Weather',
                          onTap: () {
                            context.push(AppRoutes.weatherScreen);
                          },
                        ),
                        BuildQuickGuideItemWidget(
                          svgPath: './assets/icons/Currency.svg',
                          label: 'Currency',
                          onTap: () {
                            context.push(AppRoutes.currencyScreen);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                Gap(24.h),

                // Discover All Destinations Dropdown
                DiscoverWidget(),

                // Recommended Activities Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recommended Activities',
                        style: TextStyle(fontSize: 18.sp, color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push(AppRoutes.allActivitiesScreen);
                        },
                        child: Text(
                          'View All',
                          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
