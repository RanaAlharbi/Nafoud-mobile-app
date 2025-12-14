import 'package:flutter/material.dart';

class ParticipantsAvatars extends StatelessWidget {
  final List<String> avatars;

  const ParticipantsAvatars({super.key, required this.avatars});

  @override
  Widget build(BuildContext context) {
    final visible = avatars.take(5).toList();
    final remaining = avatars.length - visible.length;

    return Row(
      children: [
        for (var url in visible)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white70,
              child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(url),
              ),
            ),
          ),

        if (remaining > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text("+$remaining",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
      ],
    );
  }
}
