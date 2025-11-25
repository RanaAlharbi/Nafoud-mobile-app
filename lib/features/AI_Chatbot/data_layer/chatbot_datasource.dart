import 'package:final_project/features/AI_Chatbot/data_layer/chatbot_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

abstract class ChatDataSource {
  ChatbotConfigModel fetchConfig();
}

@LazySingleton(as: ChatDataSource)
class ChatRemoteDataSource implements ChatDataSource {
  @override
  ChatbotConfigModel fetchConfig() {
    final apiKey = dotenv.env['GeminiAPIKey'] ?? '';
    final modelName = dotenv.env['GeminiModel'] ?? '';

    const systemInstruction =
        "You are a professional AI assistant. You should only answer questions related to saudi arabia tourism and saudi culture. Only answer questions which Saudi visitors may ask";
    const welcomeMessage =
        "Hello👋 I’m here to help with you enjoy your Saudi visit. Please tell me how I can assist you.";

    return ChatbotConfigModel(
      apiKey: apiKey,
      model: modelName,
      systemInstruction: systemInstruction,
      welcomeMessage: welcomeMessage,
    );
  }
}
