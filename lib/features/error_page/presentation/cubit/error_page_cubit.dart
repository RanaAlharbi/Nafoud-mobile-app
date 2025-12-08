import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/error_page/domain/use_cases/error_page_use_case.dart';
import 'package:final_project/features/error_page/presentation/cubit/error_page_state.dart';

class ErrorPageCubit extends Cubit<ErrorPageState> {
  final ErrorPageUseCase _errorPageUseCase;

  ErrorPageCubit(this._errorPageUseCase) : super(ErrorPageInitialState());

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

  @override
  Future<void> close() {
    //here is when close cubit
    return super.close();
  }
}
