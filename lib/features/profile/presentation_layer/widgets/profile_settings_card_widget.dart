import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSettingsCardWidget extends StatelessWidget {
  final List<Widget> children;

  const ProfileSettingsCardWidget({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    // Add lines between each child (e.g. Font Size and Appearance)
    List<Widget> childrenWithDividers = [];
    for (int i = 0; i < children.length; i++) {
      childrenWithDividers.add(children[i]);
      if (i < children.length - 1) {
        childrenWithDividers.add(Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey,
        ));
      }
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.r),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: childrenWithDividers,
      ),
    );
  }
}
