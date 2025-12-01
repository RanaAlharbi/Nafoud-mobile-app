import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> setup() async {
  await dotenv.load(fileName: ".env");

  // GetStorage (I think best place for it will be here, I hope that I remember to tell you)
  await GetStorage.init();

  await Supabase.initialize(
    url: dotenv.env['supabaseURL']!,
    anonKey: dotenv.env['supabaseAPIKey']!,
  );
}