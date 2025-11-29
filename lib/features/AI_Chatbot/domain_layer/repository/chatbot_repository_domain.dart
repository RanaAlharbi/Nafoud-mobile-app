
import 'package:final_project/features/ai_chatbot/domain_layer/entity/chatbot_entity.dart';

abstract class ChatbotRepositoryDomain {
  ChatbotEntity getChatConfiguration();
}