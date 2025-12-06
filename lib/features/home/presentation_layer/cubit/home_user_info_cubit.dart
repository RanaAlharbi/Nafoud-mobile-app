import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../../profile/domain_layer/usecase/profile_usecase.dart';

part 'home_user_info_state.dart';

@injectable
class HomeUserInfoCubit extends Cubit<HomeUserInfoState> {
  final ProfileUsecase _profileUsecase;
  StreamSubscription<void>? _profileUpdateSubscription;

  HomeUserInfoCubit(this._profileUsecase) : super(HomeUserInfoInitial()) {
    _profileUpdateSubscription = _profileUsecase.profileUpdateStream.listen((_) {
      refreshUserInfo();
    });
  }

  // Load user info silently (no loading state)
  Future<void> loadUserInfo() async {
    if (isClosed) return;

    final result = await _profileUsecase.getProfile();

    if (isClosed) return;
    result.fold(
      (error) {
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

  Future<void> refreshUserInfo() async {
    await loadUserInfo();
  }

  @override
  Future<void> close() {
    _profileUpdateSubscription?.cancel();
    return super.close();
  }
}
