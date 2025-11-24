import 'package:final_project/core/initial/setup.config.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

Future<void> setup() async {
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['supabaseURL']!,
    anonKey: dotenv.env['supabaseAPIKey']!,
  );

  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  await GetStorage.init();
  getIt.registerLazySingleton<GetStorage>(() => GetStorage());
}

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
