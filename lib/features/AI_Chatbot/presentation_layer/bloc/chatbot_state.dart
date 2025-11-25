part of 'chatbot_bloc.dart';

sealed class ChatbotState extends Equatable {
  const ChatbotState();
  
  @override
  List<Object> get props => [];
}

final class ChatbotInitial extends ChatbotState {}

class ChatbotLoading extends ChatbotState {}

class ChatbotLoaded extends ChatbotState {
  final LlmProvider provider;
  final String welcomeMessage;

  ChatbotLoaded({required this.provider, required this.welcomeMessage});
}

class ChatbotError extends ChatbotState {
  final String message;
  ChatbotError(this.message);
}