import 'package:final_project/features/AI_Chatbot/domain_layer/chatbot_entity.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'chatbot_model.mapper.dart';

@MappableClass()
class ChatbotConfigModel extends ChatbotEntity with ChatbotConfigModelMappable {
  ChatbotConfigModel({
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
