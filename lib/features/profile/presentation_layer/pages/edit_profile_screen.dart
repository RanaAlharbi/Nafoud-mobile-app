import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(),
        title: Text("Edit profile"),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(40),

        ],
      ),
    );
  }
}
