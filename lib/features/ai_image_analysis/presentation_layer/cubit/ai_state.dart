part of 'ai_cubit.dart';

abstract class AIImageState {
  const AIImageState();
}

class AIImageInitial extends AIImageState {}

class AIImageLoading extends AIImageState {}

class AIImageSuccess extends AIImageState {
  final LandmarkAnalysis analysis;
  const AIImageSuccess(this.analysis);
}

class AIImageError extends AIImageState {
  final String message;
  const AIImageError(this.message);
}