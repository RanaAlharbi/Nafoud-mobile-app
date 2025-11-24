import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/ai_image_analysis/domain_layer/usecase/ai_image_analysis_usecase.dart';
import 'package:final_project/features/ai_image_analysis/presentation_layer/cubit/ai_state.dart';

class AIImageCubit extends Cubit<AiState> {
  final AnalyzeImageUseCase analyzeImage;
  Uint8List? selectedImage;

  AIImageCubit({required this.analyzeImage}) : super(AiInitial());

 
  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      final file = result.files.first;
      Uint8List bytes;
      if (file.bytes != null) {
        bytes = file.bytes!;
      } else if (file.path != null) {
        bytes = await File(file.path!).readAsBytes();
      } else return;

      selectedImage = bytes;
      emit(AiInitial()); 
    }
  }

   Future<void> analyzeImageMethod() async { 
    if (selectedImage == null) {
      emit(AIError("Please select an image first."));
      return;
    }

    emit(AILoading());
    final result = await analyzeImage(selectedImage!); 

    result.fold(
      (error) => emit(AIError(error)),
      (data) => emit(AISuccess(data)),
    );
  }
}