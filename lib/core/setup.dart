import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> setup() async {
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['supabaseURL']!,
    anonKey: dotenv.env['supabaseAPIKey']!,
  );


}