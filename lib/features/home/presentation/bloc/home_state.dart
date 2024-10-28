import 'package:chronicle/features/game/domain/model/game_model.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus {
  initial,
  loading,
  checkGameLoading,
  success,
  successfullyCheckedGame,
  error,
  checkGameError,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errorMessage;
  final GameModel? gameModel;

  final List<GameModel>? completedGames;
  final List<GameModel>? activeGames;

  const HomeState._(
      {required this.status,
      this.errorMessage,
      this.gameModel,
      this.completedGames,
      this.activeGames});

  factory HomeState.initial() => const HomeState._(status: HomeStatus.initial);

  HomeState copyWith(
          {HomeStatus? status,
          String? errorMessage,
          GameModel? gameModel,
          List<GameModel>? activeGames,
          List<GameModel>? completedGames}) =>
      HomeState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        gameModel: gameModel ?? this.gameModel,
        completedGames: completedGames ?? this.completedGames,
        activeGames: activeGames ?? this.activeGames,
      );

  @override
  List<Object?> get props =>
      [status, errorMessage, gameModel, activeGames, completedGames];
}
