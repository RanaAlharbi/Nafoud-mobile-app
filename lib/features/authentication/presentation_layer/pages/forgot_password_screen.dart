import 'package:final_project/core/app_theme/app_text/app_text.dart';
import 'package:final_project/core/initial/setup.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:final_project/features/authentication/presentation_layer/bloc/authentication_bloc.dart';
import 'package:final_project/features/authentication/presentation_layer/widgets/authentication_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthenticationBloc>(),
      child: Builder(
        builder: (innerContext) {
          return Scaffold(
            backgroundColor: Colors.brown,
            body: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (innerContext, state) {
                if (state is AuthenticationLoading) {
                  ScaffoldMessenger.of(innerContext).showSnackBar(
                    const SnackBar(content: Text('Sending email...')),
                  );
                } else if (state is AuthenticationSuccess) {
                  ScaffoldMessenger.of(
                    innerContext,
                  ).showSnackBar(SnackBar(content: Text(state.message)));

                  innerContext.go(
                    AppRoutes.updatePasswordScreen,
                    extra: _emailCtrl.text.trim(),
                  );
                } else if (state is AuthenticationFailure) {
                  ScaffoldMessenger.of(
                    innerContext,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              child: CustomAuthenticationCardWidget(
                title: 'Forgot Password?',
                subtitle:
                    'If you need help resetting your password, we can help by sending you a code to reset it.',
                cardWidth: 334,
                cardHeight: 294,
                showUsername: false,
                showPassword: false,
                showEmail: true,
                hasForgotPassword: false,
                hasBottomText: false,
                titleTextStyle: AppText.forgotPassOTPVerifyTitle,
                buttonText: 'Continue',
                showConfirmPassword: false,
                emailController: _emailCtrl,
                onButtonPressed: () {
                  innerContext.read<AuthenticationBloc>().add(
                    ResetPasswordEmailRequested(email: _emailCtrl.text.trim()),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
