import 'package:final_project/features/AI_Chatbot/data_layer/chatbot_datasource.dart';
import 'package:final_project/features/AI_Chatbot/data_layer/chatbot_model.dart';
import 'package:final_project/features/AI_Chatbot/domain_layer/chatbot_repository_domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ChatbotRepositoryDomain)
class ChatbotRepositoryData implements ChatbotRepositoryDomain {
  final ChatRemoteDataSource _remoteDataSource;

  ChatbotRepositoryData(this._remoteDataSource);

  @override
  ChatbotConfigModel getChatConfiguration() {
    return _remoteDataSource.fetchConfig();
  }
}