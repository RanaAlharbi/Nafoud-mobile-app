import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class NotificationSelectorWidget extends StatefulWidget {
  const NotificationSelectorWidget({super.key});

  @override
  State<NotificationSelectorWidget> createState() => _NotificationSelectorWidgetState();
}

class _NotificationSelectorWidgetState extends State<NotificationSelectorWidget> {
  String selectedNotification = "ON";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(RemixIcons.notification_3_line),
      title: Text("Notifications"),
      trailing: DropdownButton<String>(
        value: selectedNotification,
        underline: SizedBox(),
        style: TextStyle(color: Color.fromRGBO(103, 70, 54, 1)),
        items: [
          DropdownMenuItem(value: "ON", child: Text("ON")),
          DropdownMenuItem(value: "OFF", child: Text("OFF")),
        ],
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedNotification = value;
            });
          }
        },
      ),
    );
  }
}
