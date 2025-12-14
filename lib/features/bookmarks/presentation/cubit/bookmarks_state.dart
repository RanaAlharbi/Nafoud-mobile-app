import 'package:equatable/equatable.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';

abstract class BookmarkState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<GatheringEntity> events;

  BookmarkLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class BookmarkError extends BookmarkState {
  final String message;

  BookmarkError(this.message);

  @override
  List<Object?> get props => [message];
}
