import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/error_page/domain/use_cases/error_page_use_case.dart';
import 'package:final_project/features/error_page/presentation/cubit/error_page_state.dart';
import 'package:final_project/features/profile/domain_layer/usecase/profile_usecase.dart';

@injectable
class ErrorPageCubit extends Cubit<ErrorPageState> {
  final ErrorPageUseCase _errorPageUseCase;
  final ProfileUsecase _profileUsecase;

  ErrorPageCubit(this._errorPageUseCase, this._profileUsecase) : super(ErrorPageInitialState());

  Future<void> getErrorPageMethod() async {
    final result = await _errorPageUseCase.getErrorPage();
    result.fold(
      (success) {
        //here is when success result
      },
      (whenError) {
       //here is when error result
      },
    );
  }

  // Sign out user and clear cache (made by Mohammed)
  Future<void> signOut() async {
    if (isClosed) return;

    // Clear cache and sign out FIRST, then emit the state
    await _profileUsecase.signOut();

    if (isClosed) return;
    emit(ErrorPageSignedOutState());
  }

  @override
  Future<void> close() {
    //here is when close cubit
    return super.close();
  }
}
