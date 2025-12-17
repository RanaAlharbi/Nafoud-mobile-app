import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

abstract class TripDataSource {
  Future<LlmProvider> initializeChatWithPrompt(String systemPrompt);
}

@LazySingleton(as: TripDataSource)
class TripRemoteDataSource implements TripDataSource {
  // Get the gemini API key from the .env file 
  final String _apiKey = dotenv.env['GeminiAPIKey']!;

  @override
  Future<LlmProvider> initializeChatWithPrompt(String systemPrompt) async {
    final model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: _apiKey);

    try {
      final content = [Content.text(systemPrompt)];
      final response = await model.generateContent(content);

      final aiResponseText = response.text;

      return GeminiProvider(
        model: model,
        history: [
          ChatMessage.user(systemPrompt, []),
          ChatMessage(
            origin: MessageOrigin.llm,
            text: aiResponseText,
            attachments: [],
          ),
        ],
      );
    } catch (e) {
      throw Exception("Failed to contact AI: $e");
    }
  }
}
