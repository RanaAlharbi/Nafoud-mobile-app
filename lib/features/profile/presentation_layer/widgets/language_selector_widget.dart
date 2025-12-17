import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageSelectorWidget extends StatefulWidget {
  const LanguageSelectorWidget({super.key});

  @override
  State<LanguageSelectorWidget> createState() => _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget> {
  String get selectedLanguage {
    return context.locale.languageCode == 'ar' ? 'العربية' : 'English';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset('assets/icons/translation.svg', height: 27.h),
      title: Text(
        "Language",
        style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold),
      ),
      trailing: PopupMenuButton<String>(
        constraints: BoxConstraints(maxHeight: 190.h),
        offset: Offset(35.w, 30.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedLanguage,
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Color.fromRGBO(109, 109, 109, 1),
            ),
          ],
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: "en",
            child: Text(
              "English",
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
            ),
          ),
          PopupMenuItem(
            value: "ar",
            child: Text(
              "العربية",
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
            ),
          ),
        ],
        onSelected: (value) async {
          if (value == "en") {
            await context.setLocale(Locale('en', 'US'));
          } else if (value == "ar") {
            await context.setLocale(Locale('ar', 'SA'));
          }
          setState(() {});
        },
      ),
    );
  }
}
