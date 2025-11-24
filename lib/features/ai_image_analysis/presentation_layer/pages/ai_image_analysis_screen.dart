import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/core/initial/setup.dart';
import 'package:final_project/features/ai_image_analysis/presentation_layer/cubit/ai_cubit.dart';
import 'package:final_project/features/ai_image_analysis/presentation_layer/cubit/ai_state.dart';

class AIImageAnalysisScreenw extends StatelessWidget {
  const AIImageAnalysisScreenw ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AIImageCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text("AI Landmark Analyzer")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BlocBuilder<AIImageCubit, AiState>(
                builder: (context, state) {
                  final cubit = context.read<AIImageCubit>();
                  return GestureDetector(
                    onTap: () => cubit.pickImage(),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
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
                                  SizedBox(height: 8),
                                  Text("Tap to select a landmark image"),
                                ],
                              ),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
