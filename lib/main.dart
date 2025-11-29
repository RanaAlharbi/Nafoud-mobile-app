// import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:final_project/core/setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  await setup();
  configureDependencies();
  runApp(const MyApp());
  // runApp(
  //   EasyLocalization(
  //     supportedLocales: const [
  //       Locale('en'),
  //       Locale('ar'),
  //       Locale('fr'),
  //       Locale('hi'),
  //       Locale('ur'),
  //     ],
  //     path: 'Assets/translations',
  //     fallbackLocale: const Locale('en'),
  //     child: const MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true, 
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: AppRoutes.appRouter,
          // localizationsDelegates: context.localizationDelegates,
          // supportedLocales: context.supportedLocales,
          // locale: context.locale,
        );
      },
    );
  }
}

