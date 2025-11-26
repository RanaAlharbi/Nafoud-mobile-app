class ChatbotEntity {
  final String apiKey;
  final String model;
  final String systemInstruction;
  final String welcomeMessage;

  const ChatbotEntity({
    required this.apiKey,
    required this.model,
    required this.systemInstruction,
    required this.welcomeMessage,
  });
}

