import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class ThemeSelectorWidget extends StatefulWidget {
  const ThemeSelectorWidget({super.key});

  @override
  State<ThemeSelectorWidget> createState() => _ThemeSelectorWidgetState();
}

class _ThemeSelectorWidgetState extends State<ThemeSelectorWidget> {
  String selectedTheme = "Light mode";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(RemixIcons.mental_health_line),
      title: Text("Theme"),
      trailing: PopupMenuButton<String>(
        offset: Offset(0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedTheme,
              style: TextStyle(color: Color.fromRGBO(103, 70, 54, 1)),
            ),
            Icon(Icons.arrow_drop_down, color: Color.fromRGBO(103, 70, 54, 1)),
          ],
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: "Light mode",
            child: Text(
              "Light mode",
              style: TextStyle(color: Color.fromRGBO(103, 70, 54, 1)),
            ),
          ),
          PopupMenuItem(
            value: "Dark mode",
            child: Text(
              "Dark mode",
              style: TextStyle(color: Color.fromRGBO(103, 70, 54, 1)),
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
