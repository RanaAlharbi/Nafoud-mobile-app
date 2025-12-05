  import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

Widget markDownCard(String text) {
    return Markdown(
      data: text,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        p: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

