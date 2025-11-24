import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/features/authentication/domain_layer/usecase/authentication_usecase.dart';
import 'package:injectable/injectable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationUsecases _usecases;

  AuthenticationBloc(this._usecases) : super(AuthenticationInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<SignInSubmitted>(_onSignInSubmitted);
    on<ResetPasswordEmailRequested>(_onResetPasswordEmailRequested);
    on<UpdatePasswordSubmitted>(_onUpdatePasswordSubmitted);
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
      await _usecases.verifyResetCode(email: event.email, code: event.code);

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
      emit(AuthenticationFailure(e.toString()));
    }
  }
}
