import 'package:chronicle/core/failure/failure.dart';
import 'package:chronicle/core/model/either.dart';
import 'package:chronicle/features/game/data/datasource/game_remote_datasource.dart';
import 'package:chronicle/features/game/domain/repository/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final GameRemoteDatasource gameRemoteDatasource;

  GameRepositoryImpl({required this.gameRemoteDatasource});

  @override
  Future<Either<Failure, void>> joinGame(
      {required String gameCode,
      required GameUpdateCallback onUpdate,
      required ErrorCallback onError,
      required KickedCallback onKicked,
      required LeftCallback onLeft}) async {
    return Either.right(gameRemoteDatasource.joinGame(
        gameCode: gameCode,
        onUpdate: onUpdate,
        onError: onError,
        onLeft: onLeft,
        onKicked: onKicked));
  }

  @override
  Future<Either<Failure, void>> startGame(String gameId) async {
    return Either.right(gameRemoteDatasource.startGame(gameId));
  }

  @override
  Future<Either<Failure, void>> cancelGame(String gameId) async {
    return Either.right(gameRemoteDatasource.cancelGame(gameId));
  }

  @override
  Future<Either<Failure, void>> kickParticipant(
      String gameId, String userId) async {
    return Either.right(gameRemoteDatasource.kickParticipant(gameId, userId));
  }

  @override
  Future<Either<Failure, void>> leaveGame(String gameId) async {
    return Either.right(gameRemoteDatasource.leaveGame(gameId));
  }

  @override
  Future<Either<Failure, void>> submitText(String gameId, String text) async {
    return Either.right(gameRemoteDatasource.submitText(gameId, text));
  }

  @override
  Future<Either<Failure, void>> submitVote(String gameId, String userId) async {
    return Either.right(gameRemoteDatasource.submitVote(gameId, userId));
  }
}
