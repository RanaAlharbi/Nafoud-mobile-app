import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';

class EventInfoSection extends StatelessWidget {
  final GatheringEntity event;

  const EventInfoSection({super.key, required this.event});

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Color(0xFF6B6F52)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: Color(0xFF3A3A3A)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _infoRow(CupertinoIcons.calendar, event.date),
        const SizedBox(height: 12),
        _infoRow(CupertinoIcons.time, event.eventTime),
        const SizedBox(height: 12),
        _infoRow(CupertinoIcons.location_solid, event.city),
      ],
    );
  }
}
