import 'package:final_project/core/app_theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../core/routes/router.dart';
import '../../domain_layer/usecase/profile_usecase.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/profile_avatar_widget.dart';
import '../widgets/profile_info_widget.dart';
import '../widgets/profile_settings_card_widget.dart';
import '../widgets/language_selector_widget.dart';
import '../widgets/font_size_selector_widget.dart';
import '../widgets/pulsing_red_shadow_container_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _pickAndUploadAvatar(BuildContext context) async {
    final cubit = context.read<ProfileCubit>();

    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Choose Image Source', style: TextStyle(fontSize: 23.h)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () => Navigator.pop(dialogContext, ImageSource.gallery),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () => Navigator.pop(dialogContext, ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        final bytes = await image.readAsBytes();
        final fileName = image.name;

        if (bytes.isNotEmpty) {
          await cubit.uploadAvatar(bytes, fileName);
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(GetIt.I.get<ProfileUsecase>())..loadProfile(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 240, 238, 1),
        extendBodyBehindAppBar: true,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Profile",
            style: TextStyle(
              color: Color.fromRGBO(61, 64, 50, 1),
              fontWeight: .bold,
              fontSize: 25.h,
            ),
          ),
          centerTitle: true,
        ),

        body: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is SignedOut) {
              context.go(AppRoutes.signInScreen);
            }
          },
          child: BlocBuilder<ProfileCubit, ProfileState>(
            buildWhen: (previous, current) =>
                (
                // (It's like saying "Don't rebuild for avatar-only changes")
                current is! AvatarUploading && current is! AvatarUploaded),
            builder: (context, state) {
              if (state is ProfileError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64.r, color: Colors.red),
                      Gap(16.h),
                      Text('Error loading profile'),
                      Gap(8.h),
                      Center(
                        child: Text(
                          state.message,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Gap(16.h),
                      Row(
                        spacing: 20.w,
                        mainAxisAlignment: .center,
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                context.read<ProfileCubit>().loadProfile(),
                            child: Text('Retry'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await context.push(AppRoutes.signInScreen);
                              if (context.mounted) {
                                context.read<ProfileCubit>().loadProfile();
                              }
                            },
                            child: Text('Leave'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }

              final profile = state is ProfileLoaded ? state.profile : null;

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(8.h),
                      // Avatar widget
                      BlocBuilder<ProfileCubit, ProfileState>(
                        buildWhen: (previous, current) {
                          // Only rebuild when avatar changes
                          return current is AvatarUploading ||
                              current is AvatarUploaded ||
                              current is ProfileLoaded ||
                              current is ProfileLoading;
                        },
                        builder: (context, avatarState) {
                          // Show shimmer when loading
                          if (avatarState is ProfileLoading) {
                            return SizedBox(
                              height: 140.r,
                              width: double.infinity,
                              child: Center(
                                child: Container(
                                  width: 140.r,
                                  height: 140.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color.fromRGBO(194, 164, 128, 1),
                                      width: 3.w,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 70.r,
                                    backgroundColor: const Color.fromRGBO(237, 234, 231, 1),
                                    child: ClipOval(
                                      child: Shimmer(
                                        duration: Duration(milliseconds: 800),
                                        color: AppColors.primaryColor,
                                        child: Container(
                                          width: 140.r,
                                          height: 140.r,
                                          color: Color.fromRGBO(241, 241, 241, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          final avatarUrl = avatarState is ProfileLoaded
                              ? avatarState.profile.avatarUrl
                              : (avatarState is AvatarUploaded
                                    ? avatarState.profile.avatarUrl
                                    : profile?.avatarUrl);

                          final fullName = avatarState is ProfileLoaded
                              ? avatarState.profile.fullName
                              : (avatarState is AvatarUploaded
                                    ? avatarState.profile.fullName
                                    : profile?.fullName);

                          return ProfileAvatarWidget(
                            avatarUrl: avatarUrl,
                            fullName: fullName,
                            isUploading: avatarState is AvatarUploading,
                            onEditTap: () => _pickAndUploadAvatar(context),
                          );
                        },
                      ),

                      Gap(5.h),

                      // Profile info
                      state is ProfileLoading
                          ? Shimmer(
                              duration: Duration(milliseconds: 800),
                              color: AppColors.primaryColor,
                              child: Container(
                                width: 150.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(241, 241, 241, 1),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                            )
                          : ProfileInfoWidget(fullName: profile?.fullName),

                      Gap(5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Account Settings",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Gap(15.h),

                      // First Card
                      ProfileSettingsCardWidget(
                        children: [
                          ListTile(
                            leading: SvgPicture.asset(
                              'assets/icons/Personal_Info.svg',
                              height: 27.h,
                            ),
                            title: Text(
                              "Personal Info",
                              style: TextStyle(
                                fontSize: 16.h,
                                fontWeight: .bold,
                              ),
                            ),
                            trailing: SvgPicture.asset(
                              'assets/Images/profile/arrow-right-01.svg',
                              height: 20.h,
                            ),
                            onTap: () async {
                              await context.push(AppRoutes.editProfileScreen);
                              if (context.mounted) {
                                context.read<ProfileCubit>().loadProfile();
                              }
                            },
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              'assets/icons/ticket.svg',
                              height: 27.h,
                            ),
                            title: Text(
                              "My Activity",
                              style: TextStyle(
                                fontSize: 16.h,
                                fontWeight: .bold,
                              ),
                            ),
                            trailing: SvgPicture.asset(
                              'assets/Images/profile/arrow-right-01.svg',
                              height: 20.h,
                            ),
                            onTap: () {
                              context.push(AppRoutes.myActivityScreen);
                            },
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              'assets/icons/Bookmark.svg',
                              height: 24.h,
                            ),
                            title: Text(
                              "Bookmark",
                              style: TextStyle(
                                fontSize: 16.h,
                                fontWeight: .bold,
                              ),
                            ),
                            trailing: SvgPicture.asset(
                              'assets/Images/profile/arrow-right-01.svg',
                              height: 20.h,
                            ),
                            onTap: () {
                              context.push(AppRoutes.bookmarkScreen);
                            },
                          ),
                        ],
                      ),
                      Gap(25.h),

                      // Accessibility settings section
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Accessibility settings",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Gap(15.h),

                      // The Second Card - Accessibility
                      ProfileSettingsCardWidget(
                        children: [
                          LanguageSelectorWidget(),
                          FontSizeSelectorWidget(),
                        ],
                      ),
                      Gap(27.h),

                      /// Old Delete Logic, DO NOT DELETE IT. the logic was hard.
                      /// We gonna remove it later on when UI/UX team choose to finish edit_profile_screen.dart
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                // Red light that comes out of the button
                                child: PulsingRedShadowContainer(
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      final shouldDelete = await showDialog<bool>(
                                        context: context,
                                        builder: (dialogContext) => AlertDialog(
                                          title: Text('Delete Account'),
                                          content: Text(
                                            'Are you sure you want to delete your account?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                dialogContext,
                                                false,
                                              ),
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                dialogContext,
                                                true,
                                              ),
                                              child: Text(
                                                'Delete Account',
                                                style: TextStyle(color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (shouldDelete == true && context.mounted) {
                                        context
                                            .read<ProfileCubit>()
                                            .deleteAccount();
                                        await context.push(AppRoutes.signInScreen);
                                      }
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      side: BorderSide(color: Colors.red, width: 1.w),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      minimumSize: Size(double.infinity, 48.h),
                                    ),
                                    child: Text(
                                      'Delete Account',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Gap(3.w),
                          // Logout Button
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: OutlinedButton(
                                onPressed: () async {
                                  final shouldSignOut = await showDialog<bool>(
                                    context: context,
                                    builder: (dialogContext) => AlertDialog(
                                      title: Text(
                                        'Sign Out',
                                        style: TextStyle(fontSize: 25.h),
                                      ),
                                      content: Text(
                                        'Are you sure you want to sign out?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(dialogContext, false),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(fontSize: 15.h),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(dialogContext, true),
                                          child: Text(
                                            'Sign Out',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15.h,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (shouldSignOut == true && context.mounted) {
                                    context.read<ProfileCubit>().signOut();
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.red,
                                  side: BorderSide(color: Colors.red, width: 1.w),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  minimumSize: Size(double.infinity, 48.h),
                                ),
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ],
                        ),
                      ),
                      Gap(25.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
