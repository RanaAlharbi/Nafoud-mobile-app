import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String hint;
  final Function(String) onChanged;
  final int minLines;
  final int maxLines;

  const CustomTextField({
    super.key,
    this.controller,
    this.initialValue,
    required this.hint,
    required this.onChanged,
    this.minLines = 1,
    this.maxLines = 1,
  }) : assert(
          controller != null || initialValue != null,
          'Either controller or initialValue must be provided',
        );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.cairo(
          color: const Color(0xffB6B6B6),
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xffB6B6B6),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xffB6B6B6),
            width: 1.5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xffB6B6B6),
          ),
        ),
      ),
    );
  }
}
