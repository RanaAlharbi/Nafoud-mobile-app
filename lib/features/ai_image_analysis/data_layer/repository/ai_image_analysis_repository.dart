import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:final_project/features/ai_image_analysis/data_layer/datasource/ai_image_analysis_datasource.dart';
import 'package:final_project/features/ai_image_analysis/domain_layer/entity/ai_landmark_analysis_entity.dart';
import 'package:final_project/features/ai_image_analysis/domain_layer/repository/ai_image_analysis_repository.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: AiImageAnalysisRepository) 
class AiImageAnalysisRepositoryDataSource implements AiImageAnalysisRepository {
final BaseAiImageAnalysisDataSource dataSource;

  AiImageAnalysisRepositoryDataSource(this.dataSource);

  @override
  Future<Either<String, LandmarkAnalysis>> analyzeImage(Uint8List imageBytes) async {
    try {
      final response = await dataSource.analyze(imageBytes);
      return Right(LandmarkAnalysis(response));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
