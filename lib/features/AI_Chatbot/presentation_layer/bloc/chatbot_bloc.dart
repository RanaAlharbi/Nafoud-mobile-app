import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/features/AI_Chatbot/domain_layer/chatbot_usecase.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

part 'chatbot_event.dart';
part 'chatbot_state.dart';

@injectable
class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  final GetChatSessionUseCase _useCase;

  ChatbotBloc(this._useCase) : super(ChatbotInitial()) {
    on<ChatbotStarted>((event, emit) {
      emit(ChatbotLoading());
      try {
        // 1. Get the Entity
        final entity = _useCase();

        // 2. Use the Entity data to create the Provider 
        final provider = GeminiProvider(
          model: GenerativeModel(
            model: entity.model,
            apiKey: entity.apiKey,
            systemInstruction: Content.system(entity.systemInstruction),
          ),
        );

        emit(ChatbotLoaded(
          provider: provider, 
          welcomeMessage: entity.welcomeMessage
        ));
      } catch (e) {
        emit(ChatbotError("Failed to start chat: $e"));
      }
    });
  }
}