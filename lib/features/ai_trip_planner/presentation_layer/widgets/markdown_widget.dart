import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:google_fonts/google_fonts.dart';

Widget markdownCard(String text) {
  // To display text in a neater way
  return Markdown(
    data: text,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    selectable: true,
    styleSheet: MarkdownStyleSheet(
      p: GoogleFonts.cairo(fontSize: 16, color: Color(0xFF000000)),
    ),
  );
}
