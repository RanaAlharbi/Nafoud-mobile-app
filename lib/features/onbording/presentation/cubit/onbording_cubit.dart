import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingCubit extends Cubit<int> {
  final PageController pageController = PageController();

  final List<String> images = [
    "assets/Images/onboarding/onboarding_1.png",
    "assets/Images/onboarding/onboarding_2.png",
    "assets/Images/onboarding/onboarding_3.png",
  ];

  final List<String> titles = [
    "Discover Nafoud Saudi Arabia",
    "Smart Guidance Everywhere",
    "Feel the Heart of Saudi",
  ];

  final List<String> descriptions = [
    "From its deserts to its cities ... we show you the Kingdom with unforgettable details",
    "Snap a landmark, ask a question, and Nafoud helps instantly",
    "Connect with locals, share your experiences and discover the culture from its heart",
  ];

  int _currentIndex = 0;

  OnboardingCubit() : super(0);

  int get currentIndex => _currentIndex;
  bool get isLastPage => _currentIndex == images.length - 1;

  void nextPage() {
    if (_currentIndex < images.length - 1) {
      _currentIndex++;
      pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      emit(_currentIndex);
    }
  }

  void skip(BuildContext context) {
    context.go('/authentication-landing');
  }

  void onPageChanged(int index) {
    _currentIndex = index;
    emit(index);
  }
}
