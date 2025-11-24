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

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(100),

          

            //avatar photo
            Stack(
              clipBehavior: Clip.none,
              children: [
                
                const CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Color.fromARGB(255, 201, 189, 161),
                  child: Icon(Icons.person, color: Colors.white, size: 50),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        RemixIcons.edit_line,
                        color: Colors.white,
                        size: 16,
                      ),
                      //Icon(Icons.edit, color: Colors.white, size: 16),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: -10,
                  // right: 0,
                  // bottom: 0,

                  child: Container(
                    height: 50.h,
                    clipBehavior: Clip.none,
                    width: 50.h,

                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
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
      ),
    );
  }
}
