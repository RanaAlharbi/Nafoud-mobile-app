import 'package:final_project/core/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // TickerProviderStateMixin is needed for the Animation controller
  // To make the splash screen speed slower
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      // duration of splash screen, in milliseconds because seconds doesn't allow for double (5.8 s)
      duration: const Duration(milliseconds: 5800),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          // Splash screen animation exported from Figma using LottieFiles plugin as a json Lottie File
          'assets/jsons/splash/SplashScreen.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              // When Finished, move to onboarding screen
              ..forward().whenComplete(
                () => context.replace(AppRoutes.onboardingScreen),
              );
          },
        ),
      ),
    );
  }
}
