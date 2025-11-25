import 'package:final_project/AI_Chat_Test/chat_screen.dart';
import 'package:final_project/core/initial/setup.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  configureDependencies();
  runApp(const MyApp());
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
        return MaterialApp(
          home: AIImageAnalysisScreen(),
        );
      },
    );
  }
}

//  BlocProvider<AuthenticationBloc>(
//       create: (_) => AuthenticationBloc(getIt<AuthenticationUsecases>()),
//       child: MaterialApp.router(routerConfig: AppRoutes.appRouter),
// );
