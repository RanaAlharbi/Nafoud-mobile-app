import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleButtonWidget extends StatelessWidget {
  final String iconPath;

  const CircleButtonWidget({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFE3E3DF),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF656A53)),
      ),
      child: SvgPicture.asset(
        iconPath,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
