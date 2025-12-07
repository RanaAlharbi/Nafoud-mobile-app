import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search here...',
        hintStyle: GoogleFonts.cairo(color: Color(0xFFB6B6B6), fontSize: 18),
        filled: true,
        fillColor: Color(0xff656A53).withValues(alpha: 0.1),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 12,
        ),

        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xFF656A53),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color(0xFF656A53), width: 1),
        ),
      ),
    );
  }
}
