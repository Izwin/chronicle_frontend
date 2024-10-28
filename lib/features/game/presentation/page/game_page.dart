import 'package:chronicle/core/di/get_it.dart';
import 'package:chronicle/features/game/domain/model/game_phase.dart';
import 'package:chronicle/features/game/presentation/bloc/game_bloc.dart';
import 'package:chronicle/features/game/presentation/bloc/game_event.dart';
import 'package:chronicle/features/game/presentation/bloc/game_state.dart';
import 'package:chronicle/features/game/presentation/page/game_canceled_page.dart';
import 'package:chronicle/features/game/presentation/page/game_finished_page.dart';
import 'package:chronicle/features/game/presentation/page/game_voting_page.dart';
import 'package:chronicle/features/game/presentation/page/game_waiting_page.dart';
import 'package:chronicle/features/game/presentation/page/game_writing_page.dart';
import 'package:chronicle/features/home/presentation/bloc/home_bloc.dart';
import 'package:chronicle/features/home/presentation/bloc/home_event.dart';
import 'package:chronicle/features/home/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GamePage extends StatelessWidget {
  final String gameCode;

  const GamePage({super.key, required this.gameCode});

  static String route(String gameCode) {
    return '${HomePage.route}/game/$gameCode';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<GameBloc>()..add(JoinGameEvent(gameCode: gameCode)),
      child: Scaffold(
        body: BlocConsumer<GameBloc, GameState>(
          builder: (context, state) {
            if(state.gamePhase == GamePhase.waiting){
              return const GameWaitingPage();
            }
            if(state.gamePhase == GamePhase.canceled){
              return const GameCanceledPage();
            }
            if(state.gamePhase == GamePhase.writing){
              return const GameWritingPage();
            }
            if(state.gamePhase == GamePhase.voting){
              return const GameVotingPage();
            }
            if(state.gamePhase == GamePhase.finished){
              return const GameFinishedPage();
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          listener: (context,state){
            if(state.previousGamePhase != state.gamePhase){
              context.read<HomeBloc>().add(GetActiveGamesEvent());
              context.read<HomeBloc>().add(GetCompletedGamesEvent());
            }
            if(state.status == GameStatus.error){
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('${state.errorMessage}')));
            }
            if(state.status == GameStatus.kicked){
              showDialog(context: context, barrierDismissible: false,builder: (context){
                return AlertDialog(
                  title: const Text('You have been kicked from the game'),
                  actions: [
                    TextButton(onPressed: (){
                      context.pop();
                      context.pop();
                    }, child: const Text('Ok'))
                  ],
                );
              });
            }
            if(state.status == GameStatus.leftGame){
              context.pop();
            }
          },
        ),
      ),
    );
  }
}
