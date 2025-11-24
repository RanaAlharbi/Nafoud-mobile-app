import 'package:final_project/core/initial/setup.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', 
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();


@module
abstract class ThirdPartySetup {
  @lazySingleton 
  GenerativeModel get generativeModel {
    final apiKey = dotenv.env['GeminiAPIKey'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("Gemini Key is missing");
    }

    return GenerativeModel(
      model: 'gemini-2.5-flash', //version of gemini
      apiKey: apiKey,
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.high),
      ],
    );
  }
}
