import 'package:final_project/core/app_theme/app_text/app_text.dart';
import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/authentication/presentation_layer/bloc/authentication_bloc.dart';
import 'package:final_project/features/authentication/presentation_layer/widgets/authentication_card_widget.dart';
import 'package:final_project/features/authentication/presentation_layer/widgets/bottom_rich_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _usernameCtrl = TextEditingController();
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
                  'Assets/Images/Sign_Up_Screen/backgroundImage.png',
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
                      const SnackBar(content: Text('Creating account...')),
                    );
                  } else if (state is AuthenticationSuccess) {
                    ScaffoldMessenger.of(innerContext).hideCurrentSnackBar();

                    ScaffoldMessenger.of(
                      innerContext,
                    ).showSnackBar(SnackBar(content: Text(state.message)));

                    /// After signup → go to Sign In
                    innerContext.go(AppRoutes.signInScreen);
                  } else if (state is AuthenticationFailure) {
                    ScaffoldMessenger.of(
                      innerContext,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: CustomAuthenticationCardWidget(
                  title: 'Sign Up',
                  subtitle: 'Create an account to continue.',
                  cardWidth: 334,
                  cardHeight: 405,
                  titleTextStyle: AppText.logInSignUpTitle,

                  showUsername: true,
                  showPassword: true,
                  showEmail: true,
                  hasForgotPassword: false,
                  hasBottomText: true,

                  bottomRichText: [
                    TextPart('Already have an account? Go to the '),
                    TextPart('Login Page', isHighlighted: true),
                  ],

                  onBottomTextTap: () {
                    innerContext.go(AppRoutes.signInScreen);
                  },

                  buttonText: 'Sign Up',
                  showConfirmPassword: false,

                  usernameController: _usernameCtrl,
                  emailController: _emailCtrl,
                  passwordController: _passwordCtrl,

                  onButtonPressed: () {
                    innerContext.read<AuthenticationBloc>().add(
                      SignUpSubmitted(
                        username: _usernameCtrl.text.trim(),
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
