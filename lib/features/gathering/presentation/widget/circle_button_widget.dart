import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

//this is a custom widget for the circle in gather screen
class CircleButtonWidget extends StatelessWidget {
  final String iconPath; //svg icon
  final VoidCallback? onTap;

  const CircleButtonWidget({super.key, required this.iconPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Container(
        width: 52.w, //responsive
        height: 52.h, // responsive

        decoration: BoxDecoration(
          color: const Color(0xFFE3E3DF),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF656A53), width: 1.w),
        ),

        child: SvgPicture.asset(iconPath, fit: BoxFit.scaleDown),
      ),
    );
  }
}
