import 'package:final_project/core/app_theme/app_text/app_text.dart';
import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/authentication/presentation_layer/bloc/authentication_bloc.dart';
import 'package:final_project/features/authentication/presentation_layer/widgets/authentication_card_widget.dart';
import 'package:final_project/features/authentication/presentation_layer/widgets/bottom_rich_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthenticationBloc>(),
      child: Builder(
        builder: (innerContext) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'Assets/Images/Sign_In_Screen/backgroundImage.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,

              body: BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (innerContext, state) {
                  if (state is AuthenticationLoading) {
                    ScaffoldMessenger.of(innerContext).showSnackBar(
                      const SnackBar(content: Text('Please wait...')),
                    );
                  } else if (state is AuthenticationSuccess) {
                    ScaffoldMessenger.of(innerContext).hideCurrentSnackBar();

                    ScaffoldMessenger.of(
                      innerContext,
                    ).showSnackBar(SnackBar(content: Text(state.message)));

                    innerContext.go(AppRoutes.navigationScreen);
                  } else if (state is AuthenticationFailure) {
                    ScaffoldMessenger.of(
                      innerContext,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: CustomAuthenticationCardWidget(
                  title: 'Log In',
                  subtitle: 'Please sign in to continue',
                  cardWidth: 334,
                  cardHeight: 362,
                  titleTextStyle: AppText.logInSignUpTitle,
                  showUsername: false,
                  showPassword: true,
                  showEmail: true,
                  hasForgotPassword: true,
                  hasBottomText: true,
                  onBottomTextTap: () {
                    innerContext.go(AppRoutes.signUpScreen);
                  },
                  onForgotPasswordTap: () {
                    innerContext.go(AppRoutes.forgotPasswordScreen);
                  },
                  bottomRichText: [
                    TextPart("Don't have an account? "),
                    TextPart('Sign Up', isHighlighted: true),
                    TextPart(' first.'),
                  ],
                  buttonText: 'Log In',
                  showConfirmPassword: false,

                  // real controllers
                  emailController: _emailCtrl,
                  passwordController: _passwordCtrl,

                  onButtonPressed: () {
                    innerContext.read<AuthenticationBloc>().add(
                      SignInSubmitted(
                        email: _emailCtrl.text.trim(),
                        password: _passwordCtrl.text.trim(),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
