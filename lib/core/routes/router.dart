import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/features/ai_image_analysis/presentation_layer/pages/ai_image_analysis_screen.dart';
import 'package:final_project/features/ai_trip_planner/domain_layer/usecase/ai_trip_usecase.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/bloc/ai_trip_planner_bloc.dart';
import 'package:final_project/features/ai_trip_planner/presentation_layer/page/ai_trip_planner_screen.dart';
import 'package:final_project/features/authentication/domain_layer/usecase/authentication_usecase.dart';
import 'package:final_project/features/authentication/presentation_layer/bloc/authentication_bloc.dart';
import 'package:final_project/features/authentication/presentation_layer/pages/authentication_landing_screen.dart';
import 'package:final_project/features/authentication/presentation_layer/pages/sign_in_screen.dart';
import 'package:final_project/features/authentication/presentation_layer/pages/sign_up_screen.dart';
import 'package:final_project/features/authentication/presentation_layer/pages/otp_screen.dart';
import 'package:final_project/features/bookmarks/presentation/cubit/bookmarks_cubit.dart';
import 'package:final_project/features/error_page/domain/use_cases/error_page_use_case.dart';
import 'package:final_project/features/error_page/presentation/cubit/error_page_cubit.dart';
import 'package:final_project/features/error_page/presentation/pages/error_page_feature_screen.dart';
import 'package:final_project/features/gathering/presentation/pages/map_screen.dart';
import 'package:final_project/features/profile/domain_layer/usecase/profile_usecase.dart';
import 'package:final_project/core/shared/gathering_entity/gathering_entity.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/pages/add_events.dart';
import 'package:final_project/features/gathering/presentation/pages/gathering_details_screen.dart';
import 'package:final_project/features/gathering/presentation/pages/select_location_screen.dart';
import 'package:final_project/features/home/presentation_layer/pages/all_activities_screen.dart';
import 'package:final_project/features/home/presentation_layer/pages/currency_screen.dart';
import 'package:final_project/features/emergency/presentation_layer/pages/emergency_screen.dart';
import 'package:final_project/features/home/presentation_layer/pages/home_screen.dart';
import 'package:final_project/features/home/presentation_layer/pages/sim_card_screen.dart';
import 'package:final_project/features/transport/presentation_layer/pages/transport_screen.dart';
import 'package:final_project/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:final_project/features/weather/presentation/pages/weather_screen.dart';
import 'package:final_project/features/navigation/presentation_layer/cubit/navigation_cubit.dart';
import 'package:final_project/features/navigation/presentation_layer/pages/navigation.dart';
import 'package:final_project/features/onbording/presentation/cubit/onbording_cubit.dart';
import 'package:final_project/features/onbording/presentation/pages/onboarding_screen.dart';
import 'package:final_project/features/bookmarks/presentation/pages/bookmark_screen.dart';
import 'package:final_project/features/profile/presentation_layer/pages/edit_profile_screen.dart';
import 'package:final_project/features/profile/presentation_layer/pages/my_activity_screen.dart';
import 'package:final_project/features/profile/presentation_layer/pages/profile_screen.dart';
import 'package:final_project/features/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRoutes {
  static const splashScreen = '/splash-screen';

  //Auth
  static const authenticationLandingScreen = '/authentication-landing';
  static const signInScreen = '/sign-in';
  static const signUpScreen = '/sign-up';
  static const forgotPasswordScreen = '/forgot-password';
  static const otpScreen = '/otp-password';

  // Home & Home Related things
  static const homeScreen = '/home';
  static const allActivitiesScreen = '/all-activities';
  static const emergencyScreen = '/emergency';
  static const transportScreen = '/transport';
  static const simCardScreen = '/sim-card';
  static const weatherScreen = '/weather';
  static const currencyScreen = '/currency';

  //profile
  static const profileScreen = '/profile-screen';
  static const editProfileScreen = '/edit-profile-screen';
  static const myActivityScreen = '/my-activity-screen';
  static const bookmarkScreen = '/bookmark-screen';

  //error page (for testing)
  static const errorPageScreen = '/error-page-screen';

  //chat bot
  static const chatScreen = '/chat';

  //ai image analysis
  static const aiImageAnalysisScreen = '/ai-image-analysis-screen';

  // Navigation
  static const navigationScreen = '/navigation_screen';

  //onboarding screen
  static const onboardingScreen = '/onboarding_screen';

  //add screen
  static const addEventScreen = '/addEvent';

  //details page
  static const eventDetails = '/eventDetails';

  //select location
  static const selectLocation = '/select-location';

  //remember_me
  static String getInitialRoute() {
    final session = GetIt.I.get<SupabaseClient>().auth.currentSession;
    final box = GetIt.I.get<GetStorage>();
    final rememberMe = box.read('remember_me') ?? false;

    if (session != null && rememberMe) {
      return AppRoutes.navigationScreen;
    }

    return AppRoutes.onboardingScreen;
  }

  static final GoRouter appRouter = GoRouter(
    initialLocation: AppRoutes.onboardingScreen,
    routes: [
      //splash screen
      GoRoute(
        path: AppRoutes.splashScreen,
        builder: (context, state) => SplashScreen(),
      ),

      //auth landing screen
      GoRoute(
        path: AppRoutes.authenticationLandingScreen,
        builder: (context, state) => AuthenticationLandingScreen(),
      ),

      //sign in screen
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

      //sign up screen
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

      //Otp screen
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

      //navigation
      GoRoute(
        path: AppRoutes.navigationScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => NavigationCubit(),
          child: const NavigationScreen(),
        ),
      ),

      //chat screen
      GoRoute(
        path: AppRoutes.chatScreen,
        builder: (context, state) {
          return BlocProvider<TripPlannerBloc>(
            create: (context) =>
                TripPlannerBloc(GetIt.I.get<GenerateTripUseCase>()),
            child: const ChatScreen(),
          );
        },
      ),

      //Ai image analysis screen
      GoRoute(
        path: AppRoutes.aiImageAnalysisScreen,
        builder: (context, state) => AIImageAnalysisScreen(),
      ),

      //map screen
      GoRoute(
        path: "/eventsMap",
        builder: (context, state) {
          final cubit = state.extra as GatheringCubit;

          return BlocProvider.value(
            value: cubit,
            child: EventsMapScreen(cubit: cubit),
          );
        },
      ),

      //event details screen
      GoRoute(
        path: AppRoutes.eventDetails,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final event = data["event"] as GatheringEntity;
          final cubit = data["cubit"] as GatheringCubit;

          return BlocProvider.value(
            value: cubit,
            child: GatheringDetailsScreen(event: event),
          );
        },
      ),

      //location selection screen
      GoRoute(
        path: AppRoutes.selectLocation,
        builder: (context, state) {
          final cubit = state.extra as GatheringCubit;

          return BlocProvider.value(
            value: cubit,
            child: SelectLocationScreen(),
          );
        },
      ),

      //Add event screen
      GoRoute(
        path: "/addEvent",
        builder: (context, state) {
          final cubit = state.extra as GatheringCubit;

          return BlocProvider.value(value: cubit, child: AddEventScreen());
        },
      ),

      // Profile & Edit Profile
      GoRoute(
        path: AppRoutes.profileScreen,
        builder: (context, state) => ProfileScreen(),
      ),

      GoRoute(
        path: AppRoutes.editProfileScreen,
        builder: (context, state) => EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.myActivityScreen,
        builder: (context, state) => MyActivityScreen(),
      ),
      GoRoute(
        path: AppRoutes.bookmarkScreen,
        builder: (context, state) {
          return BlocProvider<BookmarkCubit>(
            create: (_) => getIt<BookmarkCubit>()..loadBookmarks(),
            child: const BookmarkScreen(),
          );
        },
      ),

      // Home & Home Related things (Transport, SIM Card, Emergency, Weather, and Currency)
      GoRoute(
        path: AppRoutes.homeScreen,
        builder: (context, state) => HomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.allActivitiesScreen,
        builder: (context, state) => AllActivitiesScreen(),
      ),

      GoRoute(
        path: AppRoutes.emergencyScreen,
        builder: (context, state) => EmergencyScreen(),
      ),

      GoRoute(
        path: AppRoutes.transportScreen,
        builder: (context, state) => TransportScreen(),
      ),

      GoRoute(
        path: AppRoutes.simCardScreen,
        builder: (context, state) => SimCardScreen(),
      ),

      GoRoute(
        path: AppRoutes.weatherScreen,
        builder: (context, state) {
          return BlocProvider<WeatherCubit>(
            create: (context) => GetIt.I.get<WeatherCubit>(),
            child: const WeatherScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.currencyScreen,
        builder: (context, state) => CurrencyScreen(),
      ),

      GoRoute(
        path: AppRoutes.onboardingScreen,
        builder: (context, state) => BlocProvider(
          create: (_) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
      ),
    ],

    // Temporary Page, you can edit it to follow the flow
    errorBuilder: (context, state) => BlocProvider(
      create: (context) => ErrorPageCubit(
        GetIt.I.get<ErrorPageUseCase>(),
        GetIt.I.get<ProfileUsecase>(),
      ),
      child: const ErrorPageFeatureScreen(),
    ), // Temporary Page, you can edit it to follow the flow
  );
}
