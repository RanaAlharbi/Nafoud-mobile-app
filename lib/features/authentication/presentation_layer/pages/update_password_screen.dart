import 'dart:ui';

import 'package:final_project/core/app_theme/app_text/app_text.dart';
import 'package:final_project/core/initial/setup.dart';
import 'package:final_project/core/routes/router.dart';
import 'package:final_project/core/shared/Widgets/custom_button_widget.dart';
import 'package:final_project/features/authentication/presentation_layer/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdatePasswordScreen extends StatelessWidget {
  final String email;

  const UpdatePasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final codeCtrl = TextEditingController();
    final newPasswordCtrl = TextEditingController();
    final confirmPasswordCtrl = TextEditingController();

    return BlocProvider(
      create: (_) => getIt<AuthenticationBloc>(),
      child: Builder(
        builder: (innerContext) {
          return Scaffold(
            backgroundColor: Colors.brown,
            body: Center(
              child: BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (innerContext, state) {
                  if (state is AuthenticationLoading) {
                    ScaffoldMessenger.of(innerContext).showSnackBar(
                      const SnackBar(content: Text('Updating password...')),
                    );
                  } else if (state is AuthenticationSuccess) {
                    ScaffoldMessenger.of(
                      innerContext,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                    innerContext.go(AppRoutes.signInScreen);
                  } else if (state is AuthenticationFailure) {
                    ScaffoldMessenger.of(
                      innerContext,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      width: 334,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.5),
                            Colors.white.withValues(alpha: 0.2),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'New Password',
                            style: AppText.forgotPassOTPVerifyTitle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Enter the code sent to your email and choose a new password.',
                            style: AppText.subTitle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          TextField(
                            controller: codeCtrl,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Code from email',
                              hintStyle: AppText.inputFieldText,
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.25),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.32),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          TextField(
                            controller: newPasswordCtrl,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'New password',
                              hintStyle: AppText.inputFieldText,
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.25),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.32),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          TextField(
                            controller: confirmPasswordCtrl,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirm password',
                              hintStyle: AppText.inputFieldText,
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.25),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.32),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          CustomButtonWidget(
                            buttonWidth: 300,
                            buttonHeight: 40,
                            onPressed: () {
                              final code = codeCtrl.text.trim();
                              final newPass = newPasswordCtrl.text.trim();
                              final confirmPass = confirmPasswordCtrl.text
                                  .trim();

                              if (code.isEmpty) {
                                ScaffoldMessenger.of(innerContext).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please enter the code from email.',
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (newPass.isEmpty || confirmPass.isEmpty) {
                                ScaffoldMessenger.of(innerContext).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please fill both password fields.',
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (newPass != confirmPass) {
                                ScaffoldMessenger.of(innerContext).showSnackBar(
                                  const SnackBar(
                                    content: Text('Passwords do not match.'),
                                  ),
                                );
                                return;
                              }

                              innerContext.read<AuthenticationBloc>().add(
                                UpdatePasswordSubmitted(
                                  email: email,
                                  code: code,
                                  newPassword: newPass,
                                ),
                              );
                            },
                            text: 'Update',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
