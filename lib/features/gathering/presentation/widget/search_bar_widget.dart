import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 278,
      height: 52,
      child: CupertinoTextField(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
        placeholder: 'Search here...',
        placeholderStyle: GoogleFonts.cairo(
          color: const Color(0xFFB6B6B6),
          fontSize: 18,
        ),

        prefix: const Padding(
          padding: EdgeInsets.only(left: 10, right: 5),
          child: Icon(CupertinoIcons.search, color: Color(0xFF656A53)),
        ),

        decoration: BoxDecoration(
          color: const Color(0xFF656A53).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF656A53), width: 1),
        ),
      ),
    );
  }
}
