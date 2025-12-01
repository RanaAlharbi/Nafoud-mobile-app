part of 'ai_cubit.dart';

abstract class AIImageState {
  const AIImageState();
}

class AIImageInitial extends AIImageState {}

class AIImageLoading extends AIImageState {}

class AIImageHistoryLoaded extends AIImageState {
  final List<String> history;
  const AIImageHistoryLoaded(this.history);
}

class AIImageSuccess extends AIImageState {
  final LandmarkAnalysisEntity analysis;
  const AIImageSuccess(this.analysis);
}

class AIImagePicked extends AIImageState {
  final Uint8List image;
  AIImagePicked(this.image);
}

class AIImageError extends AIImageState {
  final String message;
  const AIImageError(this.message);
}