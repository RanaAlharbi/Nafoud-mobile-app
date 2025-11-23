import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'setup.config.dart';

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
