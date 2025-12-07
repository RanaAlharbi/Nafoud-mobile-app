  import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:google_fonts/google_fonts.dart';

Widget markDownCard(String text) {
    return Markdown(
      data: text,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        p:  GoogleFonts.cairo(fontSize: 16, color: Colors.black),
      ),
    );
  }

