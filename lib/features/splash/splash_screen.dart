// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// class SplashScreenTwo extends StatefulWidget {
//   const SplashScreenTwo({super.key});

//   @override
//   State<SplashScreenTwo> createState() => _SplashScreenTwoState();
// }

// class _SplashScreenTwoState extends State<SplashScreenTwo> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const SecondScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 308.verticalSpace,
//                 SvgPicture.asset('assets/splash/top.svg').animate().rotate(
//                   duration: 1.seconds,
//                   begin: 0,
//                   end: 1,
//                   curve: Curves.easeInOut,
//                 ),
//                 // .scale(duration: 2.seconds, curve: Curves.easeInOut),
//                 39.31.verticalSpace,
//                 SvgPicture.asset('assets/splash/middle.svg'),

//                 SvgPicture.asset('assets/splash/Vector 2.svg'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
