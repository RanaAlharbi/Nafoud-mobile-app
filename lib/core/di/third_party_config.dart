import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@module
abstract class ThirdPartySetup {
  @lazySingleton
  GetStorage get storage => GetStorage();

  @lazySingleton
  SupabaseClient get supabaseClient => Supabase.instance.client;

  @lazySingleton
  Dio get dio => Dio();

  //google map Api key
  @lazySingleton
  FlutterGooglePlacesSdk get flutterGooglePlacesSdk {
    final apiKey = dotenv.env['GoogleMapsApiKey'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("Google Maps API Key is missing");
    }

    return FlutterGooglePlacesSdk(apiKey, locale: const Locale("en"));
  }


  // FlutterGooglePlacesSdk get googlePlaces {
  //   final apiKey = dotenv.env['GoogleMapsApiKey'];

  //   if (apiKey == null || apiKey.isEmpty) {
  //     throw Exception("Google Maps API Key is missing");
  //   }

  //   return FlutterGooglePlacesSdk(apiKey, locale: const Locale("en"));
  // }

  //Gemini Api key
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
