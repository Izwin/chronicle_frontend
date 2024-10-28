import 'package:chronicle/core/failure/failure.dart';
import 'package:chronicle/core/model/either.dart';
import 'package:chronicle/features/game/domain/model/game_phase.dart';
import 'package:chronicle/features/game/domain/model/participant_model.dart';
import 'package:chronicle/features/game/domain/model/story_fragment_model.dart';

typedef GameUpdateCallback = Function({
  required String name,
  required String gameCode,
  required String gameId,
  required GamePhase phase,
  required int currentRound,
  required int rounds,
  required int votingTime,
  required int roundTime,
  required int? remainingTime,
  required int maxParticipants,
  required List<ParticipantModel> participants,
  required List<StoryFragmentModel> history,
});

typedef ErrorCallback = Function(String errorMessage);

typedef KickedCallback = Function();
typedef LeftCallback = Function();

abstract class GameRepository {
  Future<Either<Failure, void>> joinGame(
      {required String gameCode,
      required GameUpdateCallback onUpdate,
      required ErrorCallback onError,
      required KickedCallback onKicked,
      required LeftCallback onLeft});

  Future<Either<Failure, void>> startGame(String gameId);

  Future<Either<Failure, void>> cancelGame(String gameId);

  Future<Either<Failure, void>> kickParticipant(String gameId, String userId);

  Future<Either<Failure, void>> leaveGame(String gameId);

  Future<Either<Failure, void>> submitText(String gameId,String text);

  Future<Either<Failure, void>> submitVote(String gameId,String userId);
}
