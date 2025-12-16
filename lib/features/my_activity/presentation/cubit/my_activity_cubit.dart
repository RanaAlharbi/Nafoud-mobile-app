import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:final_project/features/my_activity/domain/use_cases/my_activity_use_case.dart';
import 'package:final_project/features/my_activity/presentation/cubit/my_activity_state.dart';

@injectable
class MyActivityCubit extends Cubit<MyActivityState> {
  final MyActivityUseCase _myActivityUseCase;

  MyActivityCubit(this._myActivityUseCase) : super(MyActivityInitialState());

  Future<void> getMyActivityMethod() async {
    emit(MyActivityLoadingState());
    final result = await _myActivityUseCase.getMyActivity();
    result.fold(
      (error) {
        emit(MyActivityErrorState(error));
      },
      (success) {
        emit(MyActivitySuccessState(success));
      },
    );
  }
}
