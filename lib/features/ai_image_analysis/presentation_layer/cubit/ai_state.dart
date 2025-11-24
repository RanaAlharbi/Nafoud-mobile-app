import 'package:equatable/equatable.dart';
import 'package:final_project/features/ai_image_analysis/domain_layer/entity/ai_landmark_analysis_entity.dart';

sealed class AiState extends Equatable {
  const AiState();

  @override
  List<Object?> get props => [];
}

final class AiInitial extends AiState {}

final class AILoading extends AiState {}

final class AISuccess extends AiState {
  final LandmarkAnalysis analysis;
  const AISuccess(this.analysis);

  @override
  List<Object?> get props => [analysis];
}

final class AIError extends AiState {
  final String message;
  const AIError(this.message);

  @override
  List<Object?> get props => [message];
}
