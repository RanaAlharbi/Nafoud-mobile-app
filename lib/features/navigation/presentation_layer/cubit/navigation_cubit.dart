import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/features/profile/presentation_layer/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/features/ai_image_analysis/presentation_layer/pages/ai_image_analysis_screen.dart';
import 'package:final_project/features/home/presentation_layer/pages/home_screen.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavState> {
  List<Widget> screens = [HomeScreen(), AIImageAnalysisScreen(),ProfileScreen()];
  int currentIndex = 0;

  NavigationCubit() : super(NavInitialState());

  void changeIndex({required int index}) {
    emit(NavLoadingState());
    currentIndex = index;
    emit(NavLoadedState());
  }

}
