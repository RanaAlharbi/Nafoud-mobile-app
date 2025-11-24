import 'package:final_project/features/ai_image_analysis/domain_layer/usecase/ai_image_analysis_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/ai_image_analysis/presentation_layer/cubit/ai_cubit.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

class AIImageAnalysisScreen extends StatelessWidget {
  const AIImageAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AIImageCubit(GetIt.I.get<AnalyzeImageUseCase>()),
      child: Builder(
        builder: (context) {
          final cubit = context.read<AIImageCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text("AI Landmark Analyzer"),
              centerTitle: true,
              ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // Open file picker to select an image
                        FilePickerResult? result = await FilePicker
                            .platform //open gallery
                            .pickFiles(
                              type: FileType
                                  .custom, //define  file type acceptible.
                              allowedExtensions: ['jpg', 'jpeg', 'png'],
                            );

                        if (result != null) {
                          final file = result.files.first;
                          Uint8List bytes;

                          if (file.bytes != null) {
                            bytes = file.bytes!;
                          } else if (file.path != null) {
                            bytes = await File(file.path!).readAsBytes();
                          } else
                            return;

                          // Send the image to the Cubit
                          cubit.pickImage(bytes);
                        }
                      },

                      //Image Container
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                          image: cubit.selectedImage != null
                              ? DecorationImage(
                                  image: MemoryImage(cubit.selectedImage!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: cubit.selectedImage == null
                            ? const Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                    Gap(8),
                                    Text("Tap to select a landmark image"),
                                  ],
                                ),
                              )
                            : null,
                      ),
                    ),
                    Gap(16),

                    // Button to analyze image
                    ElevatedButton(
                      onPressed: () => cubit.analyzeImage(),
                      child: const Text("Analyze Landmark"),
                    ),
                    Gap(16),
                    BlocBuilder<AIImageCubit, AIImageState>(
                      builder: (context, state) {
                        if (state is AIImageLoading) {
                          return const SpinKitFadingCircle(
                            color: Colors.black,
                            size: 50,
                          );
                        } else if (state is AIImageSuccess) {
                          return Text(state.analysis.text);
                        } else if (state is AIImageError) {
                          return Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
