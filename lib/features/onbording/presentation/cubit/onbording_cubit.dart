import 'package:easy_localization/easy_localization.dart';
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

  List<String> get titles => [
    "onboarding.title1".tr(),
    "onboarding.title2".tr(),
    "onboarding.title3".tr(),
  ];

  List<String> get descriptions => [
    "onboarding.description1".tr(),
    "onboarding.description2".tr(),
    "onboarding.description3".tr(),
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
