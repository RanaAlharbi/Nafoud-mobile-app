import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            308.verticalSpace,
            SvgPicture.asset(
              'assets/splash/top.svg',
            ).animate().slideY(begin: -1, end: 0, duration: 800.ms),

            // .rotate(
            //   duration: 1.seconds,
            //   begin: 0,
            //   end: 1,
            //   curve: Curves.easeInOut,
            // )
            // .scale(duration: 2.seconds, curve: Curves.easeInOut),
            39.31.verticalSpace,
            SvgPicture.asset(
              'assets/splash/middle.svg',
            ).animate().fadeIn(duration: 500.ms),

            SvgPicture.asset(
              'assets/splash/Vector 2.svg',
            ).animate().slideY(begin: 1, end: 0, duration: 800.ms),
          ],
        ),
      ),
    );
  }
}
