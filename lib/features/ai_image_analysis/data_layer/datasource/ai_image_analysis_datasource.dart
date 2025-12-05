import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

abstract class BaseAiImageAnalysisDataSource {
  Future<String> analyze(Uint8List imageBytes);
}

@LazySingleton(as: BaseAiImageAnalysisDataSource)
class AiImageAnalysisRemoteDataSource implements BaseAiImageAnalysisDataSource {
  final GenerativeModel model;

  AiImageAnalysisRemoteDataSource(this.model);

  @override
  Future<String> analyze(Uint8List imageBytes) async {
    const prompt = """
    You are ChatGPT Vision UI formatter.
    When analyzing an image of a real-world landmark, produce the output in clean Markdown using the following exact structure:
    # 📍 <Title of the Landmark>, <City> 🇸🇦

    ## Overview:
    Write a friendly paragraph describing the landmark:  
    - What it is  
    - Height / construction year (if known)  
    - Why it is famous  
    - Any unique architectural or cultural traits  

    ## Highlights:
    - **📍 Location:** City, Region, Country
    - **🏛️ Type:** What kind of landmark (skyscraper, mosque, tower, museum…)
    - **📝 Architecture:** Describe style + materials + what makes it special
    - **⭐ Significance:** Cultural / historical / religious meaning
    - **🍽 Nearby Places:** Give 2–4 restaurants & cafés near the location

    ---
    ### If the image is NOT from Saudi Arabia:
    Respond **only with**:
    "No recognizable Saudi Arabian landmark was detected in the image."

    Do NOT include explanations or anything outside the Markdown format.
    """;

    final content = [
      Content.multi([TextPart(prompt), DataPart("image/jpeg", imageBytes)]),
    ];

    final response = await model.generateContent(content);
    return response.text ?? "No response.";
  }
}
