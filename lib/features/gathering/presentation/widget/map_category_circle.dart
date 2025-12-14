import 'package:flutter/material.dart';

class MapCategoryCircle extends StatelessWidget {
  final IconData icon;
  final Color color;

  const MapCategoryCircle({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 22,
        color: Colors.white,
      ),
    );
  }
}
