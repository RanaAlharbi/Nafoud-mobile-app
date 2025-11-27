import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import '../../../../core/routes/router.dart';
import '../../domain_layer/usecase/profile_usecase.dart';
import '../cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _pickAndUploadAvatar(BuildContext context) async {
    final cubit = context.read<ProfileCubit>();

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final bytes = file.bytes;

        if (bytes != null) {
          final fileName = file.name;
          await cubit.uploadAvatar(bytes, fileName);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(GetIt.I.get<ProfileUsecase>())..loadProfile(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AvatarUploaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            // Reload profile to show new avatar
            context.read<ProfileCubit>().loadProfile();
          } else if (state is SignedOut) {
            context.go(AppRoutes.signInScreen);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: BackButton(),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(RemixIcons.notification_3_line),
              ),
            ],
          ),

          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is ProfileError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.red),
                      Gap(16),
                      Text('Error loading profile'),
                      Gap(8),
                      Center(child: Text(state.message, style: TextStyle(color: Colors.grey))),
                      Gap(16),
                      ElevatedButton(
                        onPressed: () => context.read<ProfileCubit>().loadProfile(),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              final profile = state is ProfileLoaded ? state.profile : null;

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Add top padding for AppBar and safe area (for the design)
                    Gap(kToolbarHeight + 40.h + ScreenUtil().statusBarHeight),

                    // Stack starts here
                    SizedBox(
                      height: 140.r,
                      width: double.infinity,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Background Circle
                          Positioned(
                            top: -280.h,
                            left: (1.sw - 445.w) / 2,
                            child: Container(
                              height: 390.sp,
                              clipBehavior: Clip.none,
                              width: 445.w,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 248, 232, 1),
                                borderRadius: BorderRadius.circular(445.w),
                              ),
                            ),
                          ),

                          // Avatar starts here
                          Positioned(
                            top: 0,
                            left: (1.sw - 140.r) / 2,
                            child: CircleAvatar(
                              radius: 70.r,
                              backgroundColor: const Color.fromARGB(255, 201, 189, 161),
                              backgroundImage: profile?.avatarUrl != null
                                  ? NetworkImage(profile!.avatarUrl!)
                                  : null,
                              child: profile?.avatarUrl == null
                                  ? Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 70.sp,
                                    )
                                  : null,
                            ),
                          ),

                          // Small pen (edit), starts here
                          Positioned(
                            bottom: -2.w,
                            left: (1.sw - 140.r) / 2 + 96.r,
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: (1.sw - 140.r) / 2 + 98.r,
                            child: GestureDetector(
                              onTap: () => _pickAndUploadAvatar(context),
                              child: CircleAvatar(
                                radius: 18.r,
                                backgroundColor: Color.fromRGBO(245, 245, 245, 1),
                                child: state is AvatarUploading
                                    ? SizedBox(
                                        width: 16.sp,
                                        height: 16.sp,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                        ),
                                      )
                                    : Icon(
                                        RemixIcons.edit_line,
                                        color: Colors.black,
                                        size: 23.sp,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Gap(40),

                    // Full name
                    Text(
                      profile?.fullName ?? 'Loading...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(103, 70, 54, 1),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Username
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '@${profile?.username ?? ''}',
                          style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Gap(4),
                    // Email and Phone
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${profile?.email ?? ''} ${profile?.phoneNumber != null ? '| ' : ''}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        if (profile?.phoneNumber != null)
                          Text(
                            profile!.phoneNumber!,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                      ],
                    ),

                    const Gap(20),

                    // First Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFfFFFF),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(RemixIcons.profile_line),
                            title: Text("Edit Profile Information"),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () => context.push(AppRoutes.editProfileScreen),
                          ),

                          ListTile(
                            leading: Icon(RemixIcons.notification_3_line),
                            title: Text("Notifications"),
                            trailing: Text(
                              "ON",
                              style: TextStyle(color: Color.fromRGBO(103, 70, 54, 1)),
                            ),
                          ),

                          ListTile(
                            leading: Icon(RemixIcons.translate_2),
                            title: Text("Language"),
                            trailing: Text(
                              "English",
                              style: TextStyle(color: Color.fromRGBO(103, 70, 54, 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),

                    // The Second Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFfFFFF),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(RemixIcons.mental_health_line),
                            title: Text("Theme"),
                            trailing: Text(
                              "Light mode",
                              style: TextStyle(color: Color.fromRGBO(103, 70, 54, 1)),
                            ),
                          ),

                          ListTile(
                            leading: Icon(RemixIcons.chat_quote_line),
                            title: Text("Contact us"),
                            trailing: Icon(Icons.chevron_right),
                          ),

                          ListTile(
                            leading: Icon(RemixIcons.lock_2_line),
                            title: Text("Privacy policy"),
                            trailing: Icon(Icons.chevron_right),
                          ),

                          ListTile(
                            leading: Icon(RemixIcons.logout_box_r_line),
                            title: Text("Sign Out"),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () async {
                              final shouldSignOut = await showDialog<bool>(
                                context: context,
                                builder: (dialogContext) => AlertDialog(
                                  title: Text('Sign Out'),
                                  content: Text('Are you sure you want to sign out?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(dialogContext, false),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(dialogContext, true),
                                      child: Text('Sign Out', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );

                              if (shouldSignOut == true && context.mounted) {
                                context.read<ProfileCubit>().signOut();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
