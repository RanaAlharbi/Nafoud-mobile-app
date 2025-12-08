import 'package:final_project/features/AI_Chatbot/presentation_layer/pages/chatbot_screen.dart';
import 'package:final_project/features/ai_image_analysis/presentation_layer/pages/ai_image_analysis_screen.dart';
import 'package:final_project/features/authentication/domain_layer/usecase/authentication_usecase.dart';
import 'package:final_project/features/authentication/presentation_layer/bloc/authentication_bloc.dart';
import 'package:final_project/features/authentication/presentation_layer/pages/authentication_landing_screen.dart';
import 'package:final_project/features/authentication/presentation_layer/pages/sign_in_screen.dart';
import 'package:final_project/features/authentication/presentation_layer/pages/sign_up_screen.dart';
import 'package:final_project/features/authentication/presentation_layer/pages/otp_screen.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/pages/add_events.dart';
import 'package:final_project/features/home/presentation_layer/pages/home_screen.dart';
import 'package:final_project/features/navigation/presentation_layer/cubit/navigation_cubit.dart';
import 'package:final_project/features/navigation/presentation_layer/pages/navigation.dart';
import 'package:final_project/features/onbording/presentation/cubit/onbording_cubit.dart';
import 'package:final_project/features/onbording/presentation/pages/onboarding_screen.dart';
import 'package:final_project/features/profile/presentation_layer/pages/edit_profile_screen.dart';
import 'package:final_project/features/profile/presentation_layer/pages/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRoutes {
  //Auth
  static const authenticationLandingScreen = '/authentication-landing';
  static const signInScreen = '/sign-in';
  static const signUpScreen = '/sign-up';
  static const forgotPasswordScreen = '/forgot-password';
  static const otpScreen = '/otp-password';
  static const homeScreen = '/home';

  //profile
  static const profileScreen = '/profile-screen';
  static const editProfileScreen = '/edit-profile-screen';

  //chat bot
  static const chatScreen = '/chat';

  //ai image analysis
  static const aiImageAnalysisScreen = '/ai-image-analysis-screen';

  // Navigationbar
  static const navigationScreen = '/navigation_screen';

  //onboarding screen

  static const onboardingScreen = '/onboarding_screen';

  static const addEventScreen = '/add-event';

  static String getInitialRoute() {
    final session = GetIt.I.get<SupabaseClient>().auth.currentSession;
    final box = GetIt.I.get<GetStorage>();
    final rememberMe = box.read('remember_me') ?? false;

    if (session != null && rememberMe) {
      return AppRoutes.navigationScreen;
    }

    return AppRoutes.authenticationLandingScreen;
  }

  static final GoRouter appRouter = GoRouter(
    initialLocation: AppRoutes.authenticationLandingScreen,
    /* GetIt.I.get<SupabaseClient>().auth.currentSession != null ? '/navigation_screen'
        : '/sign-in',*/
    routes: [
      GoRoute(
        path: AppRoutes.chatScreen,
        builder: (context, state) => ChatScreen(),
      ),

      GoRoute(
        path: AppRoutes.authenticationLandingScreen,
        builder: (context, state) => AuthenticationLandingScreen(),
      ),

      GoRoute(
        path: AppRoutes.signInScreen,
        builder: (context, state) {
          return BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(GetIt.I.get<AuthenticationUsecases>()),
            child: SignInScreen(),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.signUpScreen,
        builder: (context, state) {
          return BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(GetIt.I.get<AuthenticationUsecases>()),
            child: SignUpScreen(),
          );
        },
      ),

      // GoRoute(
      //   path: AppRoutes.forgotPasswordScreen,
      //   builder: (context, state) {
      //     return BlocProvider<AuthenticationBloc>(
      //       create: (context) =>
      //           AuthenticationBloc(GetIt.I.get<AuthenticationUsecases>()),
      //       child: ForgotPasswordScreen(),
      //     );
      //   },
      // ),
      GoRoute(
        path: AppRoutes.otpScreen,
        builder: (context, state) {
          final email = state.extra as String;

          return BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(GetIt.I.get<AuthenticationUsecases>()),
            child: OTPScreen(email: email),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.profileScreen,
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfileScreen,
        builder: (context, state) => EditProfileScreen(),
      ),

      GoRoute(
        path: AppRoutes.aiImageAnalysisScreen,
        builder: (context, state) => AIImageAnalysisScreen(),
      ),

      GoRoute(
        path: AppRoutes.homeScreen,
        builder: (context, state) => HomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.navigationScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => NavigationCubit(),
          child: const NavigationScreen(),
        ),
      ),

      GoRoute(
        path: AppRoutes.onboardingScreen,
        builder: (context, state) => BlocProvider(
          create: (_) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
      ),

      GoRoute(
        path: AppRoutes.addEventScreen,
        builder: (context, state) => BlocProvider.value(
          value: GetIt.I.get<GatheringCubit>(),
          child: const AddEventScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => HomeScreen(), //fix here
  );
}
