import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'message.dart';
import 'messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _userMessage = TextEditingController();
  bool isLoading = false;
  static const apiKey = "AIzaSyDvyGSCJUeMJ3Gt6YPbMfXSyOMFeQLPBKE";
  final List<Message> _messages = [];
  final model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);
  void sendMessage() async {
    final userMessage = _userMessage.text.trim();
    if (userMessage.isEmpty) return; // don't send empty messages

    // clear input immediately
    _userMessage.clear();

    setState(() {
      _messages.add(
        Message(isUser: true, message: userMessage, date: DateTime.now()),
      );
      isLoading = true;
    });

    final prompt = "User: $userMessage";

    try {
      final content = [Content.text(prompt)];

      // Log that we're calling the model
      print("Sending prompt to model: $prompt");

      final response = await model.generateContent(content);

      // Log full response for debugging
      print("Raw model response: $response");

      // Try several strategies to extract text (safe fallback)
      String botText = "";

      // 1) If response has a top-level 'text' (your previous code)
      try {
        // attempt to read .text
        final maybeText = (response as dynamic).text;
        if (maybeText != null &&
            maybeText is String &&
            maybeText.trim().isNotEmpty) {
          botText = maybeText;
        }
      } catch (_) {}

      // 2) If the SDK returns candidates or outputs array
      if (botText.isEmpty) {
        try {
          final cand = (response as dynamic).candidates;
          if (cand != null && cand is List && cand.isNotEmpty) {
            final first = cand[0];
            final out =
                (first as dynamic).output ??
                (first as dynamic).text ??
                first.toString();
            if (out != null && out is String && out.trim().isNotEmpty)
              botText = out;
          }
        } catch (_) {}
      }

      // 3) Last resort: toString()
      if (botText.isEmpty) {
        botText = response.toString();
      }

      setState(() {
        _messages.add(
          Message(isUser: false, message: botText, date: DateTime.now()),
        );
        isLoading = false;
      });
    } catch (e, st) {
      // Print full error and stack trace to console (very important)
      print("Error calling model.generateContent: $e");
      print(st);

      // Put the actual error text into the bubble so you can see it on-device
      final errorMessage = e.toString();

      setState(() {
        _messages.add(
          Message(
            isUser: false,
            message:
                "Error: $errorMessage\n\nSorry, something went wrong. Please try again later.",
            date: DateTime.now(),
          ),
        );
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat with Feminee',
          style: GoogleFonts.poppins(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                  onAnimatedTextFinished: () {},
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _userMessage,
              decoration: InputDecoration(hintText: 'Type your message...'),
              onSubmitted: (value) => sendMessage(),
            ),
          ),
        ],
      ),
    );
  }
}
