import 'package:chronicle/core/theme/app_colors.dart';
import 'package:chronicle/features/game/presentation/bloc/game_bloc.dart';
import 'package:chronicle/features/game/presentation/bloc/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Row(
          children: [
            Text(formatTime(state.remainingTime ?? 0),style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primary,
            ),),
            const Icon(Icons.timer,color: AppColors.primary,),
          ],
        );
      },
    );
  }

  String formatTime(int seconds){
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2,'0')}';
  }
}
