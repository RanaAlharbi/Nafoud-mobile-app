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
   void generateRecipe() async {
    //  This function creates the recipe based on the user provided image. This function is where Gemini is used.
   
    // The instructions provided tell Gemini to create a recipe based on all logical ingredients observed in the image
    String prompt = "You are an expert cook with detailed knowledge of making recipes. A user is interested in making recipes with a certain set of ingredients and have provided this. If no ingredients that can be used to realistically create food are provided, please state 'No ingredients in picture' to the user. Please generate a recipe that uses these ingredients. Please only return the following sections: Recipe Name, Ingredients, Complexity, Steps to Create. Please only return the recipe and do not return any other text in your response.";
   
    // The content is then passed to Gemini combining the instructions from the prompt and the image byte data
    final content = [
      Content.multi([
      TextPart(prompt),
      // The only accepted mime types are image/*.
      DataPart('image/jpeg', imageBytes!),
      // DataPart('image/jpeg', sconeBytes.buffer.asUint8List()),
      ])
    ];

    // The model is then run and the recipe is generated
    final recipe = await model.generateContent(content);

    // Sets state to update the display of the app
    setState(() {
      
      generatedText = recipe.text;

    });
  }
 void pickFiles() async {
    // This function enables users to pick files from their local directories
    // This is used to allow users to select the image with the ingredients they want to cook with
    // Uses the file picker Flutter library to achieve this

    // The result variable contains the user's selected file
    // The parameters here only allows the user to upload one image files
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );


    if (result != null) {
      PlatformFile file = result.files.first;

      // Updates file name and data into appropriate variables when the user selects the files
      setState(() {
        selectedFileName = file.name;
        imageBytes = file.bytes;
      });

    } else {
      // User canceled the picker
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
                  onPressed: generateRecipe,
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

