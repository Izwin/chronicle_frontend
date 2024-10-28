import 'package:chronicle/features/game/domain/model/game_phase.dart';
import 'package:chronicle/features/game/domain/model/participant_model.dart';
import 'package:chronicle/features/game/domain/model/story_fragment_model.dart';

abstract class GameEvent{

}

class JoinGameEvent extends GameEvent{
  final String gameCode;

  JoinGameEvent({required this.gameCode});
}



class GameUpdatedEvent extends GameEvent {
  final String name;
  final String gameCode;
  final String gameId;
  final GamePhase phase;
  final int currentRound;
  final int rounds;
  final int votingTime;
  final int roundTime;
  final int? remainingTime;
  final int maxParticipants;
  final List<ParticipantModel> participants;
  final List<StoryFragmentModel> history;

  GameUpdatedEvent({
    required this.name,
    required this.gameCode,
    required this.gameId,
    required this.phase,
    required this.currentRound,
    required this.rounds,
    required this.votingTime,
    required this.roundTime,
    required this.remainingTime,
    required this.maxParticipants,
    required this.participants,
    required this.history,
  });
}

class StartGameEvent extends GameEvent{

}

class CancelGameEvent extends GameEvent{

}

class KickParticipantEvent extends GameEvent{
  final String userId;

  KickParticipantEvent({required this.userId});
}

class LeaveGameEvent extends GameEvent{

}

class SubmitTextEvent extends GameEvent{
  final String text;

  SubmitTextEvent({required this.text});

}

class SubmitVoteEvent extends GameEvent{
  final String userId;

  SubmitVoteEvent({required this.userId});
}

