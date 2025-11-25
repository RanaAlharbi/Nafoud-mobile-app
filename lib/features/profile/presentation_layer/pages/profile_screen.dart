import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:remixicon/remixicon.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(RemixIcons.notification_3_line),
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(40),

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
                    child: Icon(Icons.person, color: Colors.white, size: 70.sp),
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
                      print("object");
                    },
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
                      child: Icon(
                        RemixIcons.edit_line,
                        color: Colors.black,
                        size: 23.sp,
                      ),
                      //Icon(Icons.edit, color: Colors.white, size: 16),
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'example@gmail.com |  ',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Text(
                '+966546160032',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),

          const Gap(20),

          //Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Color(0xFFFfFFFF),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(18),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Edit Profile Information"),
                  trailing: Icon(Icons.chevron_right),
                ),

                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text("Notifications"),
                  trailing: Text("ON"),
                ),

                ListTile(
                  leading: HugeIcon(
                    icon: HugeIcons.strokeRoundedMessageTranslate,
                  ),
                  title: Text("Language"),
                  trailing: Text("English"),
                ),
              ],
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
