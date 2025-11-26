import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:remixicon/remixicon.dart';

// TODO: Remember to uncomment these imports after finsihing "profile_datasource.dart" and "profile_repository.dart"
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import '../../domain_layer/usecase/profile_usecase.dart';
// import '../cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: BlocProvider after finsihing "profile_datasource.dart" and "profile_repository.dart"
    // return BlocProvider(
    //   create: (context) => ProfileCubit(GetIt.I.get<ProfileUsecase>())..loadProfile(),
    //   child: Builder(
    //     builder: (context) {
    //       final cubit = context.read<ProfileCubit>();
    return Scaffold(
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

      body: SingleChildScrollView(
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
                  // Background Circale
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
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 70.sp,
                      ),
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
                      onTap: () {
                        // TODO: Remember to implement "image picker" when "profile_datasource.dart" is ready
                        print("Edit avatar tapped");
                      },
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
                        child: Icon(
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

            // User name - phone
            const Text(
              'Abdul-Rahman Al-Nasser',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(103, 70, 54, 1),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'example@gmail.com |  ',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  '+966546160032',
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
                children: const [
                  ListTile(
                    leading: Icon(RemixIcons.profile_line),
                    title: Text("Edit Profile Information"),
                    trailing: Icon(Icons.chevron_right),
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
                children: const [
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
                ],
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
    // TODO: !!!!!!!!!!!!!!!!!!  HERE after uncommenting (BlocProvider) !!!!!!!!!!!!!!!!!!
    //     );
    //   },
    // ),
  }
}
