import 'package:flutter/material.dart';

class TransportTabs extends StatelessWidget {
  final int currentIndex;
  final List<IconData> icons;
  final List<String> labels;
  final Function(int) onTap;

  const TransportTabs({
    super.key,
    required this.currentIndex,
    required this.icons,
    required this.labels,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: icons.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (_, i) {
          final selected = i == currentIndex;

          return GestureDetector(
            onTap: () => onTap(i),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? const Color(0xFF656A53)
                          : const Color(0xFF656A53).withValues(alpha: 0.1),
                      border: Border.all(
                        color: const Color(0xFF5E6345),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      icons[i],
                      size: 40,
                      color: selected
                          ? Colors.white
                          : const Color(0xFF5E6345),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    labels[i],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          selected ? FontWeight.bold : FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
