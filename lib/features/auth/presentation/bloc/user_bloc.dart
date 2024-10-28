import 'package:chronicle/features/auth/domain/repository/auth_repository.dart';
import 'package:chronicle/features/auth/domain/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  UserBloc({required this.authRepository, required this.userRepository})
      : super(UserState.initial()) {
    on<LoginWithGoogleEvent>(onLoginWithGoogleEvent);
    on<GetUserEvent>(onGetUserEvent);
    on<LogoutEvent>(onLogoutEvent);
  }

  Future onLoginWithGoogleEvent(
      LoginWithGoogleEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var data = await authRepository.loginWithGoogle();
    if (data.isRight()) {
      emit(state.copyWith(status: UserStatus.success, userModel: data.right));
    } else {
      emit(state.copyWith(
          status: UserStatus.error, errorMessage: data.left.message));
    }
  }

  Future onGetUserEvent(GetUserEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var data = await userRepository.getUser();
    if (data.isRight()) {
      emit(state.copyWith(status: UserStatus.success, userModel: data.right));
    } else {
      emit(state.copyWith(
          status: UserStatus.error, errorMessage: data.left.message));
    }
  }

  Future onLogoutEvent(LogoutEvent event, Emitter emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var result = await authRepository.logout();
    if (result.isRight()) {
      emit(state.copyWith(status: UserStatus.logout));
    } else {
      emit(state.copyWith(
          status: UserStatus.error, errorMessage: result.left.message));
    }
  }
}
