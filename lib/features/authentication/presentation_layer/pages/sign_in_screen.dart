import 'package:final_project/core/app_theme/app_text/app_text.dart';
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('Assets/Images/Sign_In_Screen/backgroundImage.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
              context.go(AppRoutes.navigationScreen);
            } else if (state is AuthenticationFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return CustomAuthenticationCardWidget(
              title: 'Log In',
              subtitle: 'Please sign in to continue',
              cardWidth: 334,
              cardHeight: 390,
              titleTextStyle: AppText.logInSignUpTitle,
              showUsername: false,
              showPassword: true,
              showEmail: true,
              hasForgotPassword: true,
              hasBottomText: true,
              onBottomTextTap: () {
                context.go(AppRoutes.signUpScreen);
              },
              onForgotPasswordTap: () {
                context.go(AppRoutes.forgotPasswordScreen);
              },
              bottomRichText: [
                TextPart("Don't have an account? "),
                TextPart('Sign Up', isHighlighted: true),
                TextPart(' first.'),
              ],
              buttonText: 'Log In',
              showConfirmPassword: false,
              emailController: _emailCtrl,
              passwordController: _passwordCtrl,

              isLoading: state is AuthenticationLoading,

              onButtonPressed: () {
                context.read<AuthenticationBloc>().add(
                  SignInSubmitted(
                    email: _emailCtrl.text.trim(),
                    password: _passwordCtrl.text.trim(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
