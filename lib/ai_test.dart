import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIImageAnalysisScreen extends StatefulWidget {
  const AIImageAnalysisScreen({super.key});

  @override
  State<AIImageAnalysisScreen> createState() => _AIImageAnalysisScreenState();
}

class _AIImageAnalysisScreenState extends State<AIImageAnalysisScreen> {
  String selectedFileName = '';
  Uint8List? imageBytes;
  String generatedText = '';
  late final model;

  void getAPIKey() async {
    await dotenv.load(fileName: ".env");
    var geminiAPIKey = dotenv.env['GeminiAPIKey'] ?? '';
    model = GenerativeModel(
      model: 'gemini-2.5-flash', // maybe gemini-2.5-flash-lite
      apiKey: geminiAPIKey,
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.high),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getAPIKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI Test"),
        //backgroundColor: Colors.color,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Put here a function to pick the image or file
                    },

                    style: ElevatedButton.styleFrom(
                      // backgroundColor: ,
                      // foregroundColor: ,
                      // elevation
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        (selectedFileName == '')
                            ? Text('Select a photo of the landmark')
                            : Text(selectedFileName),
                        Icon(Icons.image),
                      ],
                    ),
                  ),
                ),

                Gap(8),
                ElevatedButton(
                  onPressed: () {
                    // Generate Result
                  },
                  style: ElevatedButton.styleFrom(
                    // backgroundColor:
                    //foregroundColor:
                  ),
                  child: Text("Upload Image"),
                ),
              ],
            ),
            Gap(24),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  //color:
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: double.infinity),
                    child: SelectableText(
                      generatedText,
                      // style: TextStyle(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
