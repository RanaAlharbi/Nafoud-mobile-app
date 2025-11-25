import 'package:final_project/features/AI_Chatbot/domain_layer/chatbot_entity.dart';
import 'package:final_project/features/AI_Chatbot/domain_layer/chatbot_repository_domain.dart';

class GetChatSessionUseCase {
  final ChatbotRepositoryDomain _repository;

  GetChatSessionUseCase(this._repository);

  ChatbotEntity call() {
    return _repository.getChatConfiguration();
  }
}