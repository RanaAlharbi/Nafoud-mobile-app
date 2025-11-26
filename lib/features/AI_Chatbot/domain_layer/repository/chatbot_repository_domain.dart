import 'package:final_project/features/AI_Chatbot/domain_layer/chatbot_entity.dart';

abstract class ChatbotRepositoryDomain {
  ChatbotEntity getChatConfiguration();
}