import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';


abstract class BaseAiImageAnalysisDataSource  {
  Future<String> analyze(Uint8List imageBytes);
}

@LazySingleton(as: BaseAiImageAnalysisDataSource )
class AiImageAnalysisRemoteDataSource  implements BaseAiImageAnalysisDataSource  {
  final GenerativeModel model;

  AiImageAnalysisRemoteDataSource(this.model);

  @override
  Future<String> analyze(Uint8List imageBytes) async {
    
    const prompt = """
    You are a highly knowledgeable historian specializing in Saudi Arabia.
    Provide the following in English:
    1. Name of the Place  
    2. City & Region  
    3. Historical Background  
    4. Cultural or Religious Significance  
    5. Interesting Facts
    6. Nearby places restaurant, cafe

    If the landmark is not in Saudi Arabia, respond:
    'No recognizable Saudi Arabian landmark was detected in the image.'
    """;

    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart("image/jpeg", imageBytes),
      ])
    ];

    final response = await model.generateContent(content);
    return response.text ?? "No response.";
  }
}
