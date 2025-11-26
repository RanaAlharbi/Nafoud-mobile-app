
import 'package:final_project/features/AI_Chatbot/domain_layer/entity/chatbot_entity.dart';
import 'package:final_project/features/AI_Chatbot/domain_layer/repository/chatbot_repository_domain.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetChatSessionUseCase {
  final ChatbotRepositoryDomain _repository;

  GetChatSessionUseCase(this._repository);

  ChatbotEntity call() {
    return _repository.getChatConfiguration();
  }
}