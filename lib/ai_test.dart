import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
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
  GenerativeModel? model;
  bool isLoading = false;

  void getAPIKey() async {
    await dotenv.load(fileName: ".env");
    var geminiAPIKey = dotenv.env['GeminiAPIKey'] ?? '';

    if (geminiAPIKey.isEmpty) {
      print("Error: Gemini API Key is empty!");
      return;
    }

    model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: geminiAPIKey,
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.high),
      ],
    );
    print("Gemini model initialized.");
  }

  void analyzeImage() async {
    if (imageBytes == null) {
      setState(() {
        generatedText = "Please select an image first.";
      });
      return;
    }

    if (model == null) {
      setState(() {
        generatedText = "Gemini model not initialized or API key missing.";
      });
      return;
    }

    setState(() {
      isLoading = true;
      generatedText = "";
    });

String prompt = """
You are a highly knowledgeable historian and cultural guide specializing in Saudi Arabia. 
A user has uploaded an image that likely depicts a tourist landmark, historical site, or culturally significant location within Saudi Arabia.

Your task is to carefully analyze the image and provide ONLY the following information in English:

1. Name of the Place
2. City & Region (within Saudi Arabia)
3. Historical Background
4. Cultural or Religious Significance
5. Interesting Facts

If the landmark is not located in Saudi Arabia, or if you cannot confidently identify it, respond with: 
'No recognizable Saudi Arabian landmark was detected in the image.'

Please be clear, concise, and informative. Use complete sentences and provide engaging content suitable for someone interested in history and tourism.
""";



    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', imageBytes!),
      ])
    ];

    try {
      final response = await model!.generateContent(content);
      setState(() {
        generatedText = response.text ?? "No response was generated.";
      });
    } catch (e) {
      setState(() {
        generatedText = "An error occurred: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      Uint8List bytes;
      if (file.bytes != null) {
        bytes = file.bytes!;
      } else if (file.path != null) {
        bytes = await File(file.path!).readAsBytes();
      } else {
        print("Error: file has no bytes and no path.");
        return;
      }

      setState(() {
        selectedFileName = file.name;
        imageBytes = bytes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAPIKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Landmark Analyzer")),
     body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: pickFiles,
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
                  onPressed: isLoading  ? null : analyzeImage,
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