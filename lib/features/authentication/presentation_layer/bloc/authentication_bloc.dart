import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/features/authentication/domain_layer/usecase/authentication_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationUsecases _usecases;

  AuthenticationBloc(this._usecases) : super(AuthenticationInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<SignInSubmitted>(_onSignInSubmitted);
    on<ResetPasswordEmailRequested>(_onResetPasswordEmailRequested);
    on<UpdatePasswordSubmitted>(_onUpdatePasswordSubmitted);
    on<VerifyEmailSubmitted>(_onVerifyEmailSubmitted);
    on<VerifyResetCodeSubmitted>(_onVerifyResetCodeSubmitted);
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await _usecases.signUp(
        username: event.username,
        email: event.email,
        password: event.password,
      );

      emit(
        const AuthenticationSuccess(
          'Account created successfully. Please check your email to verify it.',
        ),
      );
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await _usecases.signIn(email: event.email, password: event.password);
      final storage = GetIt.I.get<GetStorage>();
      storage.write('remember_me', event.rememberMe);

      emit(const AuthenticationSuccess('Logged in successfully.'));
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onResetPasswordEmailRequested(
    ResetPasswordEmailRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await _usecases.sendResetPasswordEmail(email: event.email);
      emit(
        const AuthenticationSuccess(
          'Reset password email sent. Please check your inbox.',
        ),
      );
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onUpdatePasswordSubmitted(
    UpdatePasswordSubmitted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await _usecases.updatePassword(
        email: event.email,
        newPassword: event.newPassword,
      );
      emit(
        const AuthenticationSuccess(
          'Password updated successfully. You can now log in with your new password.',
        ),
      );
    } catch (e) {
      print('🚨 UPDATE PASSWORD ERROR: $e'); // <--- CHECK THIS CONSOLE OUTPUT
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onVerifyEmailSubmitted(
    VerifyEmailSubmitted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await _usecases.verifyEmailOtp(email: event.email, otp: event.otp);

      emit(
        const AuthenticationSuccess(
          'Email verified successfully. You can now sign in.',
        ),
      );
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }

  Future<void> _onVerifyResetCodeSubmitted(
    VerifyResetCodeSubmitted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      await _usecases.verifyResetCode(email: event.email, code: event.code);

      emit(
        const AuthenticationSuccess(
          'Code verified successfully. Proceed to update your password.',
        ),
      );
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }
}
