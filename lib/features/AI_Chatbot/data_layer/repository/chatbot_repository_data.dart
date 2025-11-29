
import 'package:final_project/features/ai_chatbot/data_layer/datasource/chatbot_datasource.dart';
import 'package:final_project/features/ai_chatbot/data_layer/model/chatbot_model.dart';
import 'package:final_project/features/ai_chatbot/domain_layer/repository/chatbot_repository_domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ChatbotRepositoryDomain)
class ChatbotRepositoryData implements ChatbotRepositoryDomain {
  final ChatDataSource _remoteDataSource;

  ChatbotRepositoryData(this._remoteDataSource);

  @override
  ChatbotConfigModel getChatConfiguration() {
    return _remoteDataSource.fetchConfig();
  }
}


