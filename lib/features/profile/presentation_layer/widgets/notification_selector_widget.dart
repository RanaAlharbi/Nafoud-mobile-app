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
      title: Text("My Activity"),
      trailing: PopupMenuButton<String>(
        offset: Offset(0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedNotification,
              style: TextStyle(color: Color.fromRGBO(103, 70, 54, 1)),
            ),
            Icon(Icons.arrow_drop_down, color: Color.fromRGBO(103, 70, 54, 1)),
          ],
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: "ON",
            child: Text(
              "ON",
              style: TextStyle(color: Color.fromRGBO(103, 70, 54, 1)),
            ),
          ),
          PopupMenuItem(
            value: "OFF",
            child: Text(
              "OFF",
              style: TextStyle(color: Color.fromRGBO(103, 70, 54, 1)),
            ),
          ),
        ],
        onSelected: (value) {
          setState(() {
            selectedNotification = value;
          });
        },
      ),
    );
  }
}
