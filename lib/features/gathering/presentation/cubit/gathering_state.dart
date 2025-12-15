import 'package:equatable/equatable.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:flutter/material.dart';

abstract class GatheringState extends Equatable {
  final String selectedCategory;

  const GatheringState({required this.selectedCategory});

  @override
  List<Object?> get props => [selectedCategory];
}

class GatheringInitial extends GatheringState {
  const GatheringInitial() : super(selectedCategory: "All");
}

class GatheringLoading extends GatheringState {
  const GatheringLoading({required super.selectedCategory});
}

class GatheringLoadingWithCategory extends GatheringState {
  const GatheringLoadingWithCategory(String category)
    : super(selectedCategory: category);
}

class GatheringLoaded extends GatheringState {
  final List<GatheringEntity> events;

  const GatheringLoaded({
    required this.events,
    required String selectedCategory,
  }) : super(selectedCategory: selectedCategory);

  @override
  List<Object?> get props => [events, selectedCategory];
}

class GatheringParticipantsLoaded extends GatheringState {
  final List<String> avatars;

  const GatheringParticipantsLoaded({
    required this.avatars,
    required super.selectedCategory,
  });

  @override
  List<Object?> get props => [avatars, selectedCategory];
}

class GatheringMessage extends GatheringState {
  final String message;

  const GatheringMessage({
    required this.message,
    required super.selectedCategory,
  });

  @override
  List<Object?> get props => [message, selectedCategory];
}




class GatheringFormUpdated extends GatheringState {
  final String? selectedImageUrl;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final double? selectedLat;
  final double? selectedLng;
  final bool isUploadingImage;

  const GatheringFormUpdated({
    required super.selectedCategory,
    this.selectedImageUrl,
    this.selectedDate,
    this.selectedTime,
    this.selectedLat,
    this.selectedLng,
    this.isUploadingImage = false,
  });



  @override
  List<Object?> get props => [
    selectedCategory,
    selectedImageUrl,
    selectedDate,
    selectedTime,
    selectedLat,
    selectedLng,
    isUploadingImage,
  ];
}

class GatheringParticipantsLoading extends GatheringState {
  const GatheringParticipantsLoading({required super.selectedCategory});
}

class GatheringError extends GatheringState {
  final String message;
  final bool isUploadingImage;

  const GatheringError({
    required this.message,
    required super.selectedCategory,
    this.isUploadingImage = false,
  });

  @override
  List<Object?> get props => [message, selectedCategory];
}
