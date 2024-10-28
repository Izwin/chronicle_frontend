import 'package:bloc/bloc.dart';
import 'package:chronicle/features/game/domain/model/game_phase.dart';
import 'package:chronicle/features/game/domain/model/participant_model.dart';
import 'package:chronicle/features/game/domain/model/story_fragment_model.dart';
import 'package:chronicle/features/game/domain/repository/game_repository.dart';
import 'package:chronicle/features/game/presentation/bloc/game_event.dart';
import 'package:chronicle/features/game/presentation/bloc/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository;

  GameBloc({required this.gameRepository}) : super(GameState.initial()) {
    on<JoinGameEvent>(onJoinGameEvent);
    on<StartGameEvent>(onStartGameEvent);
    on<CancelGameEvent>(onCancelGameEvent);
    on<KickParticipantEvent>(onKickParticipantEvent);
    on<LeaveGameEvent>(onLeaveGameEvent);
    on<SubmitTextEvent>(onSubmitTextEvent);
    on<SubmitVoteEvent>(onSubmitVoteEvent);
  }

  Future onJoinGameEvent(JoinGameEvent event, Emitter emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    gameRepository.joinGame(
        gameCode: event.gameCode,
        onUpdate: onGameUpdate,
        onError: onErrorCallback,
        onKicked: onKickedCallback,
        onLeft: onLeftGameCallback);
  }

  Future onStartGameEvent(StartGameEvent event, Emitter emit) async {
    if (state.gameId != null) {
      emit(state.copyWith(status: GameStatus.loading));
      gameRepository.startGame(state.gameId!);
    }
  }

  Future onCancelGameEvent(CancelGameEvent event, Emitter emit) async {
    if (state.gameId != null) {
      emit(state.copyWith(status: GameStatus.loading));
      gameRepository.cancelGame(state.gameId!);
    }
  }

  Future onKickParticipantEvent(
      KickParticipantEvent event, Emitter emit) async {
    if (state.gameId != null) {
      gameRepository.kickParticipant(state.gameId!, event.userId);
    }
  }

  Future onLeaveGameEvent(LeaveGameEvent event, Emitter emit) async {
    if (state.gameId != null) {
      gameRepository.leaveGame(state.gameId!);
    }
  }

  Future onSubmitTextEvent(SubmitTextEvent event, Emitter emit) async {
    if(state.gameId!=null){
      gameRepository.submitText(state.gameId!, event.text);
    }
  }
  Future onSubmitVoteEvent(SubmitVoteEvent event, Emitter emit) async {
    if(state.gameId!=null){
      gameRepository.submitVote(state.gameId!, event.userId);
    }
  }
  void onGameUpdate({
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
  }) {
    emit(state.copyWith(
        previousGamePhase: state.gamePhase,
        gamePhase: phase,
        gameCode: gameCode,
        gameId: gameId,
        currentRound: currentRound,
        rounds: rounds,
        votingDuration: votingTime,
        participants: participants,
        history: history,
        maximumParticipants: maxParticipants,
        remainingTime: remainingTime,
        roundDuration: roundTime,
        title: name));
  }

  void onErrorCallback(String errorMessage) {
    emit(state.copyWith(status: GameStatus.error, errorMessage: errorMessage));
  }

  void onLeftGameCallback() {
    emit(state.copyWith(status: GameStatus.leftGame));
  }

  void onKickedCallback() {
    emit(state.copyWith(status: GameStatus.kicked));
  }
}
