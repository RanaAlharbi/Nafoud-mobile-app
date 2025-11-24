import 'dart:convert';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:final_project/AI_chatbot/message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<Message> msgs = [];

  bool isTyping = false;

  static const String _defaultApiKey =
      "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";
  Future<void> _scrollToTop() async {
    if (!scrollController.hasClients) return;
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      final double target = scrollController.position.minScrollExtent;
      await scrollController.animateTo(
        target,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      debugPrint('Scroll failed: $e');
    }
  }

  Future<void> sendMsg() async {
    final String text = controller.text.trim();
    const String apiKey = String.fromEnvironment(
      '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',
      defaultValue: _defaultApiKey,
    );

    controller.clear();

    if (text.isEmpty) return;

    setState(() {
      msgs.insert(0, Message(true, text));
      isTyping = true;
    });

    await _scrollToTop();

    try {
      final uri = Uri.parse('https://api.openai.com/v1/chat/completions');
      final body = jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': text},
        ],
        'max_tokens': 600,
        'temperature': 0.7,
      });

      debugPrint('=== Sending to OpenAI ===');
      debugPrint('URI: $uri');
      debugPrint('Body: $body');
      debugPrint('API key length: ${apiKey.length}');

      final response = await http
          .post(
            uri,
            headers: {
              'Authorization': 'Bearer $apiKey',
              'Content-Type': 'application/json',
            },
            body: body,
          )
          .timeout(const Duration(seconds: 20));

      debugPrint('=== OpenAI response ===');
      debugPrint('statusCode: ${response.statusCode}');
      debugPrint('headers: ${response.headers}');
      debugPrint('body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final content = json['choices']?[0]?['message']?['content'];
        final reply = (content == null)
            ? 'Empty response from model.'
            : content.toString().trim();

        // Insert assistant message and stop typing
        if (mounted) {
          setState(() {
            isTyping = false;
            msgs.insert(0, Message(false, reply));
          });
        }

        await _scrollToTop();
      } else {
        // Non-200: show an assistant-style error message (for debug)
        final err = 'API error ${response.statusCode}: ${response.body}';
        debugPrint(err);
        if (mounted) {
          setState(() {
            isTyping = false;
            msgs.insert(0, Message(false, 'Error: Could not get response'));
          });
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(err)));
        await _scrollToTop();
      }
    } catch (e, st) {
      debugPrint('Exception during OpenAI request: $e');
      debugPrint('$st');
      if (mounted) {
        setState(() {
          isTyping = false;
          msgs.insert(0, Message(false, 'Error: network or request failed'));
        });
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Network/request error: $e')));
      await _scrollToTop();
    } finally {
      // ensure typing indicator turns off
      if (mounted) {
        setState(() => isTyping = false);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use SchedulerBinding to ensure initial scroll happens after first frame if needed.
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Bot')),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: msgs.length,
              shrinkWrap: true,
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                final m = msgs[index];
                // bubble horizontal padding so it doesn't touch the screen edges
                final horizontalPadding = m.isSender ? 40.0 : 12.0;
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    4,
                    m.isSender ? 12.0 : 40.0,
                    4,
                  ),
                  child: BubbleNormal(
                    text: m.msg,
                    isSender: m.isSender,
                    color: m.isSender
                        ? Colors.blue.shade100
                        : Colors.grey.shade200,
                  ),
                );
              },
            ),
          ),

          // Typing indicator (separate)
          if (isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // you can replace with animated dots if desired
                    Text('Typing...'),
                  ],
                ),
              ),
            ),

          // Input row
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: controller,
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted: (value) => sendMsg(),
                        textInputAction: TextInputAction.send,
                        showCursor: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter text',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: sendMsg,
                child: Container(
                  height: 44,
                  width: 44,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
