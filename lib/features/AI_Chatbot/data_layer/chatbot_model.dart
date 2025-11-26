import 'package:final_project/features/AI_Chatbot/domain_layer/chatbot_entity.dart';

class ChatbotConfigModel extends ChatbotEntity {
  const ChatbotConfigModel({
    required String apiKey,
    required String model,
    required String systemInstruction,
    required String welcomeMessage,
  }) : super(
          apiKey: apiKey,
          model: model,
          systemInstruction: systemInstruction,
          welcomeMessage: welcomeMessage,
        );
}