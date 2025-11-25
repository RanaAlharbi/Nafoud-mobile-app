import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  final Function onAnimatedTextFinished;
  final isAnimated = ValueNotifier(false);
  Messages({
    Key? key,
    required this.isUser,
    required this.message,
    required this.date,
    required this.onAnimatedTextFinished,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(
        vertical: 5,
      ).copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
      decoration: BoxDecoration(
        color: isUser ? Colors.blueAccent : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isUser
              ? Text(message, style: TextStyle(color: Colors.white))
              : GestureDetector(
                  onLongPress: () async {
                    await Clipboard.setData(ClipboardData(text: message));
                  },
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        message,
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ],
                    totalRepeatCount: 1,
                    isRepeatingAnimation: false,
                    onFinished: () {
                      isAnimated.value = true;
                      onAnimatedTextFinished();
                    },
                  ),
                ),
          Text("\n$date", style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
