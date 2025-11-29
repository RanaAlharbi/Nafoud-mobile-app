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
      trailing: DropdownButton<String>(
        value: selectedTheme,
        underline: SizedBox(),
        style: TextStyle(color: Color.fromRGBO(103, 70, 54, 1)),
        items: [
          DropdownMenuItem(value: "Light mode", child: Text("Light mode")),
          DropdownMenuItem(value: "Dark mode", child: Text("Dark mode")),
        ],
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedTheme = value;
            });
          }
        },
      ),
    );
  }
}
