import 'package:bloc/bloc.dart';
import 'package:chronicle/features/create_game/domain/repository/create_game_repository.dart';
import 'package:chronicle/features/create_game/presentation/bloc/create_game_event.dart';
import 'package:chronicle/features/create_game/presentation/bloc/create_game_state.dart';

class CreateGameBloc extends Bloc<CreateGameEvent, CreateGameState> {
  final CreateGameRepository createGameRepository;

  CreateGameBloc({required this.createGameRepository})
      : super(CreateGameState.initial()){
    on<CreateGameEvent>(onCreateGameEvent);
  }

  Future onCreateGameEvent(CreateGameEvent event, Emitter emit) async {
    emit(state.copyWith(status: CreateGameStatus.loading));
    var result = await createGameRepository.createGame(
        title: event.title,
        rounds: event.rounds,
        roundDuration: event.roundDuration,
        votingDuration: event.votingDuration,
        maximumParticipants: event.maximumParticipants);

    if (result.isRight()) {
      emit(state.copyWith(
          status: CreateGameStatus.success, createdGameCode: result.right));
    } else {
      emit(state.copyWith(status: CreateGameStatus.error));
    }
  }
}
