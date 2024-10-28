import 'package:chronicle/core/failure/failure.dart';
import 'package:chronicle/core/model/either.dart';
import 'package:chronicle/features/game/domain/model/game_model.dart';

abstract class HomeRepository{
  Future<Either<Failure,GameModel>> checkGameByCode(String gameCode);

  Future<Either<Failure,List<GameModel>>> getActiveGames();

  Future<Either<Failure,List<GameModel>>> getCompletedGames();
}