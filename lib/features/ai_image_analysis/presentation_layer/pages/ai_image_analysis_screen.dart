import 'package:final_project/features/ai_image_analysis/domain_layer/usecase/ai_image_analysis_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/ai_image_analysis/presentation_layer/cubit/ai_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
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
                    // Image
                    BlocBuilder<AIImageCubit, AIImageState>(
                      builder: (context, state) {
                        final selectedImage = cubit.selectedImage;

                        return Container(
                          width: double.infinity,
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                            image: selectedImage != null
                                ? DecorationImage(
                                    image: MemoryImage(selectedImage),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: selectedImage == null
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
                                      Text("No image selected"),
                                    ],
                                  ),
                                )
                              : null,
                        );
                      },
                    ),

                    const Gap(15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.photo),
                          label: const Text("Gallery"),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final XFile? picked = await picker.pickImage(
                              source: ImageSource.gallery,
                            );

                            if (picked != null) {
                              final bytes = await picked.readAsBytes();
                              cubit.pickImage(bytes);
                            }
                          },
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.camera_alt),
                          label: const Text("Camera"),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final XFile? picked = await picker.pickImage(
                              source: ImageSource.camera,
                            );

                            if (picked != null) {
                              final bytes = await picked.readAsBytes();
                              cubit.pickImage(bytes);
                            }
                          },
                        ),
                      ],
                    ),

                    const Gap(20),

                    // Analyze button
                    ElevatedButton(
                      onPressed: () => cubit.analyzeImage(),
                      child: const Text("Analyze Landmark"),
                    ),

                    const Gap(20),
                    BlocBuilder<AIImageCubit, AIImageState>(
                      builder: (context, state) {
                        if (state is AIImageLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is AIImageSuccess) {
                          return SizedBox(
                            height: 1000,
                            child: Markdown(
                              data: state.analysis.text,
                              selectable: true,
                              styleSheet: MarkdownStyleSheet(
                                p: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        } else if (state is AIImageHistoryLoaded) {
                          return SizedBox(
                            height: 1000,
                            child: Markdown(
                              data: state.history.last,
                              selectable: true,
                               styleSheet: MarkdownStyleSheet(
                                p: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        } else if (state is AIImageError) {
                          return Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          );
                        }
                        return const SizedBox.shrink();
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
