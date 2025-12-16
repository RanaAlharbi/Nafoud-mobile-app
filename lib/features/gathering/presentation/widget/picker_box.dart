import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PickerBox extends StatelessWidget {
  final String text;
  final String icon;

  const PickerBox({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      margin: const EdgeInsets.only(top: 6, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFFB6B6B6)
        )
      ),
      child: Row(
        children: [
          Expanded(child: Text(text,style: GoogleFonts.cairo(
            color: Color(0xffB6B6B6),
            fontSize: 18
          ),)),
          SvgPicture.asset(icon),
        ],
      ),
    );
  }
}
