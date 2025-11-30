import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/ai_image_analysis/domain_layer/usecase/ai_image_analysis_usecase.dart';
import 'package:final_project/features/ai_image_analysis/domain_layer/entity/ai_landmark_analysis_entity.dart';

part 'ai_state.dart';

class AIImageCubit extends Cubit<AIImageState> {
  final AnalyzeImageUseCase _useCase;
  Uint8List? selectedImage;

  AIImageCubit(this._useCase) : super(AIImageInitial()) {
    _loadHistory(); 
  }

  Future<void> pickImage(Uint8List bytes) async {
    selectedImage = bytes;
    emit(AIImageInitial());
  }

  Future<void> analyzeImage() async {
    if (selectedImage == null) {
      emit(AIImageError("Please select an image first."));
      return;
  }

    emit(AIImageLoading());

    final result = await _useCase.analyzeImage(selectedImage!);

    result.fold(
      (error) => emit(AIImageError(error)),
      (data) => emit(AIImageSuccess(data)),
    );
  }

Future<void> _loadHistory() async {
  final history = await _useCase.getHistory(); 
  if (history.isNotEmpty) {
    emit(AIImageHistoryLoaded(history));
  }
}
}
