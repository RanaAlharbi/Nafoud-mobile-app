import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../../profile/domain_layer/usecase/profile_usecase.dart';

part 'home_user_info_state.dart';

@injectable
class HomeUserInfoCubit extends Cubit<HomeUserInfoState> {
  final ProfileUsecase _profileUsecase;

  HomeUserInfoCubit(this._profileUsecase) : super(HomeUserInfoInitial());

  // Load user info silently (no loading state)
  Future<void> loadUserInfo() async {
    if (isClosed) return;

    final result = await _profileUsecase.getProfile();

    if (isClosed) return;
    result.fold(
      (error) {
        // Keep previous state or initial if error occurs
        if (state is! HomeUserInfoLoaded) {
          emit(HomeUserInfoInitial());
        }
      },
      (profile) {
        if (!isClosed) {
          emit(HomeUserInfoLoaded(
            fullName: profile.fullName,
            avatarUrl: profile.avatarUrl,
          ));
        }
      },
    );
  }

  // Refresh user info silently
  Future<void> refreshUserInfo() async {
    await loadUserInfo();
  }
}
