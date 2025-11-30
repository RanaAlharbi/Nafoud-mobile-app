import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/features/AI_Chatbot/presentation_layer/widget/chatbot_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chatbot_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatbotBloc>()..add(ChatbotStarted()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Text("AI ChatBot"),
        ),
        body: BlocBuilder<ChatbotBloc, ChatbotState>(
          builder: (context, state) {
            if (state is ChatbotLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatbotLoaded) {
              return ChatHeaderWidget(
                provider: state.provider,
                welcomeMessage: state.welcomeMessage,
              );
            } else if (state is ChatbotError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
