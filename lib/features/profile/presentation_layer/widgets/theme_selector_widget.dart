import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';

class ThemeSelectorWidget extends StatefulWidget {
  const ThemeSelectorWidget({super.key});

  @override
  State<ThemeSelectorWidget> createState() => _ThemeSelectorWidgetState();
}

class _ThemeSelectorWidgetState extends State<ThemeSelectorWidget> {
  String selectedTheme = "light";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(RemixIcons.mental_health_line),
      title: Text("Appearance", style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold),),
      trailing: PopupMenuButton<String>(
        offset: Offset(0, 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$selectedTheme ',
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1), fontSize: 12.h),
            ),
            SvgPicture.asset('assets/Images/profile/arrow-right-01.svg', height: 20.h,),
          ],
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: "light",
            child: Text(
              "light",
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
            ),
          ),
          PopupMenuItem(
            value: "dark",
            child: Text(
              "dark",
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
            ),
          ),
        ],
        onSelected: (value) {
          setState(() {
            selectedTheme = value;
          });
        },
      ),
    );
  }
}
