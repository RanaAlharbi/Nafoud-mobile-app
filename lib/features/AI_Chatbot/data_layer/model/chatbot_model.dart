import 'package:final_project/features/AI_Chatbot/domain_layer/entity/chatbot_entity.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'chatbot_model.mapper.dart';

@MappableClass()
class ChatbotConfigModel extends ChatbotEntity with ChatbotConfigModelMappable {
  ChatbotConfigModel({
    required super.apiKey,
    required super.model,
    required super.systemInstruction,
    required super.welcomeMessage,
  });
}
