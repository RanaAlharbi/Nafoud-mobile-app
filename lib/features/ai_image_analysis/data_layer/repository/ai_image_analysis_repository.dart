import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:final_project/features/ai_image_analysis/data_layer/datasource/ai_image_analysis_datasource.dart';
import 'package:final_project/features/ai_image_analysis/data_layer/datasource/ai_local_storage_datasource.dart';
import 'package:final_project/features/ai_image_analysis/data_layer/model/ai_image_analysis_model.dart';
import 'package:final_project/features/ai_image_analysis/domain_layer/repository/ai_image_analysis_repository.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: AiImageAnalysisRepository)
class AiImageAnalysisRepositoryDataSource implements AiImageAnalysisRepository {
  final BaseAiImageAnalysisDataSource remoteDataSource;
  final BaseAiLocalStorageDataSource localDataSource;

  AiImageAnalysisRepositoryDataSource(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<String, AiImageAnalysisModel>> analyzeImage(Uint8List imageBytes) async {
    try {
      final response = await remoteDataSource.analyze(imageBytes);
      await localDataSource.saveAnalysis(response);
      return Right(AiImageAnalysisModel(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<List<String>> getHistory() async {
    return localDataSource.getHistory();
  }
}

