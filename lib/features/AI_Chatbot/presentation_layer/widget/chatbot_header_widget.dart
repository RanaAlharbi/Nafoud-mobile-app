import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

class ChatHeaderWidget extends StatelessWidget {
  final LlmProvider provider;
  final String welcomeMessage;

  const ChatHeaderWidget({
    super.key,
    required this.provider,
    required this.welcomeMessage,
  });

  @override
  Widget build(BuildContext context) {
    return LlmChatView(
      suggestions: const [
        "What are great places to visit in Riyadh",
        "What are the biggest upcoming events in Saudi Arabia?",
        "What's considered rude in Saudi culture?",
      ],
      style: LlmChatViewStyle(
        backgroundColor: Colors.white,
        chatInputStyle: ChatInputStyle(
          hintText: "Enter your message",
          decoration: const BoxDecoration().copyWith(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      provider: provider,
      welcomeMessage: welcomeMessage,
    );
  }
}