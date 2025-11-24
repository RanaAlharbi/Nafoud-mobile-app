import 'package:final_project/core/initial/setup.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/authentication/domain_layer/usecase/authentication_usecase.dart';
import 'package:final_project/features/authentication/presentation_layer/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //change here 
    return BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(getIt<AuthenticationUsecases>()),
      child: MaterialApp.router(routerConfig: AppRoutes.appRouter),
    );
  }
}

