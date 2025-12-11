import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class LanguageSelectorWidget extends StatefulWidget {
  const LanguageSelectorWidget({super.key});

  @override
  State<LanguageSelectorWidget> createState() => _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget> {
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(RemixIcons.translate_2),
      title: Text("Language", style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold),),
      trailing: PopupMenuButton<String>(
        offset: Offset(0, 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedLanguage,
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
            ),
            Icon(Icons.arrow_drop_down, color: Color.fromRGBO(109, 109, 109, 1)),
          ],
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: "English",
            child: Text(
              "English",
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
            ),
          ),
          PopupMenuItem(
            value: "Arabic",
            child: Text(
              "Arabic",
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
            ),
          ),
          PopupMenuItem(
            value: "French",
            child: Text(
              "French",
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
            ),
          ),
          PopupMenuItem(
            value: "Urdu",
            child: Text(
              "Urdu",
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
            ),
          ),
          PopupMenuItem(
            value: "Hindi",
            child: Text(
              "Hindi",
              style: TextStyle(color: Color.fromRGBO(109, 109, 109, 1)),
            ),
          ),
        ],
        onSelected: (value) {
          setState(() {
            selectedLanguage = value;
          });
        },
      ),
    );
  }
}
