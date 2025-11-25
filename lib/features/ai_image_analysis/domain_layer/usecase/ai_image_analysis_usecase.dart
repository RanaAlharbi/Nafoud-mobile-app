import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:final_project/features/ai_image_analysis/domain_layer/entity/ai_landmark_analysis_entity.dart';
import 'package:final_project/features/ai_image_analysis/domain_layer/repository/ai_image_analysis_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AnalyzeImageUseCase {
  final AiImageAnalysisRepository repository;

  AnalyzeImageUseCase(this.repository);

  Future<Either<String, LandmarkAnalysisEntity>> analyzeImage(Uint8List imageBytes) {
    return repository.analyzeImage(imageBytes);
  }
}
