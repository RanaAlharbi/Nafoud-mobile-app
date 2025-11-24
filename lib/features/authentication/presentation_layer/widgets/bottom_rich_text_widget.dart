import 'package:flutter/material.dart';

class TextPart {
  final String textPart;
  final bool isHighlighted;

  TextPart(this.textPart, {this.isHighlighted = false});
}

class BottomRichTextWidget extends StatelessWidget {
  final List<TextPart> fullSentence;

  const BottomRichTextWidget({super.key, required this.fullSentence});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: fullSentence.map((part) {
          return TextSpan(
            text: part.textPart,
            style: TextStyle(
              color: part.isHighlighted
                  ? Color(0xFFFFB703)
                  : Colors.white.withValues(alpha: 0.85),
              fontSize: 10,
              fontWeight: part.isHighlighted
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          );
        }).toList(),
      ),
    );
  }
}
