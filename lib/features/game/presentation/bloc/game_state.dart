import 'package:chronicle/features/game/domain/model/game_phase.dart';
import 'package:chronicle/features/game/domain/model/participant_model.dart';
import 'package:chronicle/features/game/domain/model/story_fragment_model.dart';
import 'package:equatable/equatable.dart';

enum GameStatus { initial, loading, error, success, leftGame, kicked }

class GameState extends Equatable {
  final GameStatus status;
  final String? gameCode;
  final String? gameId;
  final GamePhase? gamePhase;
  final GamePhase? previousGamePhase;
  final String? errorMessage;
  final String? title;
  final int? roundDuration;
  final int? votingDuration;
  final int? rounds;
  final int? remainingTime;
  final int? currentRound;
  final int? maximumParticipants;
  final List<ParticipantModel>? participants;
  final List<StoryFragmentModel>? history;

  const GameState._(
      {required this.status,
      this.gameCode,
      this.gameId,
      this.previousGamePhase,
      this.gamePhase,
      this.errorMessage,
      this.title,
      this.roundDuration,
      this.votingDuration,
      this.rounds,
      this.remainingTime,
      this.currentRound,
      this.maximumParticipants,
      this.participants,
      this.history});

  factory GameState.initial() => const GameState._(status: GameStatus.initial);

  GameState copyWith(
      {GameStatus? status,
      String? gameId,
      String? gameCode,
      GamePhase? gamePhase,
      GamePhase? previousGamePhase,
      String? errorMessage,
      String? title,
      int? roundDuration,
      int? votingDuration,
      int? rounds,
      int? remainingTime,
      int? currentRound,
      int? maximumParticipants,
      List<ParticipantModel>? participants,
      List<StoryFragmentModel>? history}) {
    return GameState._(
        status: status ?? this.status,
        gameId: gameId ?? this.gameId,
        gameCode: gameCode ?? this.gameCode,
        gamePhase: gamePhase ?? this.gamePhase,
        previousGamePhase: previousGamePhase ?? this.previousGamePhase,
        errorMessage: errorMessage ?? this.errorMessage,
        title: title ?? this.title,
        roundDuration: roundDuration ?? this.roundDuration,
        votingDuration: votingDuration ?? this.votingDuration,
        rounds: rounds ?? this.rounds,
        remainingTime: remainingTime ?? this.remainingTime,
        currentRound: currentRound ?? this.currentRound,
        maximumParticipants: maximumParticipants ?? this.maximumParticipants,
        participants: participants ?? this.participants,
        history: history ?? this.history);
  }

  @override
  List<Object?> get props => [
        status,
        gameId,
        gameCode,
        gamePhase,
        errorMessage,
        title,
        roundDuration,
        votingDuration,
        rounds,
        remainingTime,
        currentRound,
        maximumParticipants,
        participants,
        previousGamePhase,
        history
      ];
}
