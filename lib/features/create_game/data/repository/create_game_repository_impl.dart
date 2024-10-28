import 'package:chronicle/core/failure/failure.dart';
import 'package:chronicle/core/model/either.dart';
import 'package:chronicle/features/create_game/data/datasource/create_game_remote_datasource.dart';
import 'package:chronicle/features/create_game/domain/repository/create_game_repository.dart';
import 'package:dio/dio.dart';

class CreateGameRepositoryImpl implements CreateGameRepository {
  final CreateGameRemoteDatasource createGameRemoteDatasource;

  CreateGameRepositoryImpl({required this.createGameRemoteDatasource});

  @override
  Future<Either<Failure, String>> createGame(
      {required String title,
      required int rounds,
      required int roundDuration,
      required int votingDuration,
      required int maximumParticipants}) async {
    try {
      var gameCode = await createGameRemoteDatasource.createGame(
          title: title,
          rounds: rounds,
          roundDuration: roundDuration,
          votingDuration: votingDuration,
          maximumParticipants: maximumParticipants);
      return Either.right(gameCode);
    } on DioException catch (e) {
      return Either.left(CreateGameFailure(message: e.response?.data['error']));
    } catch (e) {
      return Either.left(CreateGameFailure(message: 'Create game error'));
    }
  }
}
