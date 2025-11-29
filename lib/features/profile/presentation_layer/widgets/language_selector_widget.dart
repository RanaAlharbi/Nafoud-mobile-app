import 'package:flutter/material.dart';
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
      title: Text("Language"),
      trailing: DropdownButton<String>(
        value: selectedLanguage,
        underline: SizedBox(),
        style: TextStyle(color: Color.fromRGBO(103, 70, 54, 1)),
        items: [
          DropdownMenuItem(value: "English", child: Text("English")),
          DropdownMenuItem(value: "Arabic", child: Text("Arabic")),
          DropdownMenuItem(value: "French", child: Text("French")),
          DropdownMenuItem(value: "Urdu", child: Text("Urdu")),
          DropdownMenuItem(value: "Hindi", child: Text("Hindi")),
        ],
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedLanguage = value;
            });
          }
        },
      ),
    );
  }
}
