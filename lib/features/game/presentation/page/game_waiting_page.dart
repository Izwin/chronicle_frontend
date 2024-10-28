import 'package:chronicle/core/theme/app_colors.dart';
import 'package:chronicle/core/ui/widgets/default_button.dart';
import 'package:chronicle/core/utils/game_utils.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_state.dart';
import 'package:chronicle/features/game/presentation/bloc/game_bloc.dart';
import 'package:chronicle/features/game/presentation/bloc/game_event.dart';
import 'package:chronicle/features/game/presentation/bloc/game_state.dart';
import 'package:chronicle/features/game/presentation/widget/participants_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GameWaitingPage extends StatelessWidget {
  const GameWaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          return BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 35,
                      )),
                  Text(
                    'Waiting',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  if (GameUtils.isCreator(
                      userState.userModel!, state.participants ?? []))
                    TextButton(
                      onPressed: () {
                        context.read<GameBloc>().add(CancelGameEvent());
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          textStyle:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.errorColor,
                                  ),
                          foregroundColor: AppColors.errorColor,
                          alignment: Alignment.center),
                      child: const Text('Cancel game'),
                    )
                ],
              );
            },
          );
        },
      ),
      titleSpacing: 0,
      toolbarHeight: 60,
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            return SizedBox.expand(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'Join via code',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                            text: '${state.gameCode}'));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Game code copied')));
                                      },
                                      child: Text(
                                        '${state.gameCode}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                                color: AppColors.primary,
                                                letterSpacing: 6),
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.title}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        children: [
                                      const TextSpan(text: 'Round duration: '),
                                      TextSpan(
                                          text:
                                              '${state.roundDuration! ~/ 60} minutes',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500))
                                    ])),
                                const SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        children: [
                                      const TextSpan(text: 'Voting duration: '),
                                      TextSpan(
                                          text:
                                              '${state.votingDuration! ~/ 60} minutes',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500))
                                    ])),
                                const SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        children: [
                                      const TextSpan(text: 'Rounds: '),
                                      TextSpan(
                                          text: '${state.rounds}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500))
                                    ])),
                                const SizedBox(
                                  height: 30,
                                ),
                                const ParticipantsWidget()
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (GameUtils.isCreator(
                      userState.userModel!, state.participants ?? []))
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: DefaultButton(
                        text: 'Start',
                        backgroundColor: AppColors.secondary,
                        textColor: AppColors.textColor,
                        onPressed: () {
                          context.read<GameBloc>().add(StartGameEvent());
                        },
                      ),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
