import 'dart:io';
import 'dart:typed_data';
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
import '../widgets/profile_avatar_widget.dart';
import '../widgets/profile_info_widget.dart';
import '../widgets/profile_settings_card_widget.dart';
import '../widgets/language_selector_widget.dart';
import '../widgets/notification_selector_widget.dart';
import '../widgets/theme_selector_widget.dart';

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
        Uint8List? bytes;

        if (file.path != null) {
          final fileData = File(file.path!);
          bytes = await fileData.readAsBytes();
        }

        if (bytes != null && bytes.isNotEmpty) {
          final fileName = file.name;
          await cubit.uploadAvatar(bytes, fileName);
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to read image data')),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to pick image: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(GetIt.I.get<ProfileUsecase>())..loadProfile(),
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
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(RemixIcons.notification_3_line),
              ),
            ],
          ),

          body: BlocBuilder<ProfileCubit, ProfileState>(
            buildWhen: (previous, current) => ( 
              // (It's like saying "Don't rebuild for avatar-only changes")
              current is! AvatarUploading && current is! AvatarUploaded
            ),
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
                      Center(
                        child: Text(
                          state.message,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Gap(16),
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

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Add top padding for AppBar and safe area (for the design)
                    Gap(kToolbarHeight + 40.h + ScreenUtil().statusBarHeight),

                    // Avatar widget
                    BlocBuilder<ProfileCubit, ProfileState>(
                      buildWhen: (previous, current) {
                        // Only rebuild when avatar changes
                        return current is AvatarUploading ||
                               current is AvatarUploaded ||
                               current is ProfileLoaded;
                      },
                      builder: (context, avatarState) {
                        final avatarUrl = avatarState is ProfileLoaded
                            ? avatarState.profile.avatarUrl
                            : (avatarState is AvatarUploaded
                                ? avatarState.profile.avatarUrl
                                : profile?.avatarUrl);

                        return ProfileAvatarWidget(
                          avatarUrl: avatarUrl,
                          isUploading: avatarState is AvatarUploading,
                          onEditTap: () => _pickAndUploadAvatar(context),
                        );
                      },
                    ),

                    const Gap(40),

                    // Profile info
                    ProfileInfoWidget(
                      fullName: profile?.fullName,
                      username: profile?.username,
                      email: profile?.email,
                      phoneNumber: profile?.phoneNumber,
                    ),

                    const Gap(20),

                    // First Card
                    ProfileSettingsCardWidget(
                      children: [
                        ListTile(
                          leading: Icon(RemixIcons.profile_line),
                          title: Text("Edit Profile Information"),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () async {
                            await context.push(AppRoutes.editProfileScreen);
                            if (context.mounted) {
                              context.read<ProfileCubit>().loadProfile();
                            }
                          },
                        ),
                        NotificationSelectorWidget(),
                        LanguageSelectorWidget(),
                      ],
                    ),
                    const Gap(20),

                    // The Second Card
                    ProfileSettingsCardWidget(
                      children: [
                        ThemeSelectorWidget(),
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
                                content: Text(
                                  'Are you sure you want to sign out?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext, false),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext, true),
                                    child: Text(
                                      'Sign Out',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (shouldSignOut == true && context.mounted) {
                              context.read<ProfileCubit>().signOut();
                            }
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            RemixIcons.delete_bin_7_fill,
                            color: Colors.red,
                          ),
                          title: Text(
                            "Delete Account",
                            style: TextStyle(color: Colors.red),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.red,
                          ),
                          onTap: () async {
                            final shouldDelete = await showDialog<bool>(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                title: Text('Delete Account'),
                                content: Text(
                                  'Are you sure you want to delete your account?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext, false),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext, true),
                                    child: Text(
                                      'Delete Account',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (shouldDelete == true && context.mounted) {
                              context.read<ProfileCubit>().deleteAccount();
                              await context.push(AppRoutes.signInScreen);
                            }
                          },
                        ),
                      ],
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
