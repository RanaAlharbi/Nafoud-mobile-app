import 'package:final_project/ai_test.dart';
import 'package:final_project/core/initial/setup.dart';
import 'package:final_project/features/ai_image_analysis/presentation_layer/pages/ai_image_analysis_screen.dart' hide AIImageAnalysisScreen;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const AIImageAnalysisScreen());
  }
}

