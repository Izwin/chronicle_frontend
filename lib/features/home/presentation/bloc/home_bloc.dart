import 'package:bloc/bloc.dart';
import 'package:chronicle/features/home/domain/repository/home_repository.dart';
import 'package:chronicle/features/home/presentation/bloc/home_event.dart';
import 'package:chronicle/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeState.initial()) {
    on<CheckGameByCodeEvent>(onCheckGameByCodeEvent);
    on<GetCompletedGamesEvent>(onGetCompletedGamesEvent);
    on<GetActiveGamesEvent>(onGetActiveGamesEvent);
  }

  Future onCheckGameByCodeEvent(
      CheckGameByCodeEvent event, Emitter emit) async {
    emit(state.copyWith(status: HomeStatus.checkGameLoading));
    var result = await homeRepository.checkGameByCode(event.gameCode);
    if (result.isRight()) {
      emit(state.copyWith(
          status: HomeStatus.successfullyCheckedGame, gameModel: result.right));
    } else {
      emit(state.copyWith(
          status: HomeStatus.checkGameError, errorMessage: result.left.message));
    }
  }

  Future onGetActiveGamesEvent(GetActiveGamesEvent event, Emitter emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    var result = await homeRepository.getActiveGames();
    if (result.isRight()) {
      emit(state.copyWith(
          status: HomeStatus.success, activeGames: result.right));
    } else {
      emit(state.copyWith(
          status: HomeStatus.error, errorMessage: result.left.message));
    }
  }

  Future onGetCompletedGamesEvent(GetCompletedGamesEvent event, Emitter emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    var result = await homeRepository.getCompletedGames();
    if (result.isRight()) {
      emit(state.copyWith(
          status: HomeStatus.success, completedGames: result.right));
    } else {
      emit(state.copyWith(
          status: HomeStatus.error, errorMessage: result.left.message));
    }
  }
}
