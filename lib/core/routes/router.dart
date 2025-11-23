import 'package:final_project/features/authentication/presentation_layer/pages/forgot_password_screen.dart';
import 'package:final_project/features/authentication/presentation_layer/pages/sign_in_screen.dart';
import 'package:final_project/features/authentication/presentation_layer/pages/sign_up_screen.dart';
import 'package:final_project/features/authentication/presentation_layer/pages/update_password_screen.dart';
import 'package:final_project/features/home/presentation_layer/pages/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  // Auth
  static const signInScreen = '/sign-in';
  static const signUpScreen = '/sign-up';
  static const forgotPasswordScreen = '/forgot-password';
  static const updatePasswordScreen = '/update-password';
  static const homeScreen = '/home'; 

  static final GoRouter appRouter = GoRouter(
    initialLocation: AppRoutes.signInScreen,
    routes: [
      GoRoute(
        path: AppRoutes.signInScreen,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUpScreen,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPasswordScreen,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.updatePasswordScreen,
        builder: (context, state) {
          final email = state.extra as String;
          return UpdatePasswordScreen(email: email);
        },
      ),

      GoRoute(
        path: AppRoutes.homeScreen,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
