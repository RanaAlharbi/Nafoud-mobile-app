// import 'package:flutter/material.dart';
// import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: const Text("AI ChatBot"),
//       ),
//       body: LlmChatView(
//         suggestions: const [
//           "What are great places to visit in Riyadh",
//           "What are the biggest upcoming events in Saudi Arabia?",
//           "What's considered rude in Saudi culture?",
//         ],
//         style: LlmChatViewStyle(
//           backgroundColor: Colors.white,
//           chatInputStyle: ChatInputStyle(
//             hintText: "Enter your message",
//             decoration: const BoxDecoration().copyWith(
//               borderRadius: BorderRadius.circular(50),
//             ),
//           ),
//         ),
//         provider: GeminiProvider(
//           model: GenerativeModel(
//             model: 'gemini-2.5-flash',
//             apiKey: "AIzaSyDvyGSCJUeMJ3Gt6YPbMfXSyOMFeQLPBKE",
//             systemInstruction: Content.system(
//               "You are a professional AI assistant. You should only answer questions related to saudi arabia tourism and saudi culture. Only answer questions which Saudi visitors may ask",
//             ),
//           ),
//         ),
//         welcomeMessage:
//             "Hello👋 I’m here to help with you enjoy your Saudi visit. Please tell me how I can assist you.",
//       ),
//     );
//   }
// }
