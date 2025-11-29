import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:final_project/features/ai_image_analysis/domain_layer/entity/ai_landmark_analysis_entity.dart';

abstract class AiImageAnalysisRepository {
  Future<Either<String, LandmarkAnalysisEntity>> analyzeImage(Uint8List imageBytes);
  Future<List<String>> getHistory();

}