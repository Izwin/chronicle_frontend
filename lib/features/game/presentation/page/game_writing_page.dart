import 'package:chronicle/core/theme/app_colors.dart';
import 'package:chronicle/core/ui/widgets/default_button.dart';
import 'package:chronicle/core/ui/widgets/default_text_field.dart';
import 'package:chronicle/core/utils/game_utils.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_state.dart';
import 'package:chronicle/features/game/presentation/bloc/game_bloc.dart';
import 'package:chronicle/features/game/presentation/bloc/game_event.dart';
import 'package:chronicle/features/game/presentation/bloc/game_state.dart';
import 'package:chronicle/features/game/presentation/widget/history_widget.dart';
import 'package:chronicle/features/game/presentation/widget/participants_widget.dart';
import 'package:chronicle/features/game/presentation/widget/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GameWritingPage extends StatefulWidget {
  const GameWritingPage({super.key});

  @override
  State<GameWritingPage> createState() => _GameWritingPageState();
}

class _GameWritingPageState extends State<GameWritingPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
                    'Round ${state.currentRound}/${state.rounds}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  const TimerWidget(),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        context.read<GameBloc>().add(LeaveGameEvent());
                      },
                      icon: const Icon(Icons.logout)),
                  const SizedBox(
                    width: 10,
                  ),
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
                            Text(
                              '${state.title}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.primary,
                                  ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const HistoryWidget(),
                            const SizedBox(
                              height: 15,
                            ),
                            DefaultTextField(
                              hintText:
                                  'Start the story! Be the first to add a twist!',
                              controller: _controller,
                              borderRadius: BorderRadius.circular(14),
                              minLines: 4,
                              maxLines: 6,
                              maxLength: 255,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const ParticipantsWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GameUtils.hasSubmitted(
                            userState.userModel!, state.participants ?? [])
                        ? Text(
                            'Waiting',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        : DefaultButton(
                            text: 'Submit',
                            backgroundColor: AppColors.secondary,
                            textColor: AppColors.textColor,
                            onPressed: _controller.text.isNotEmpty
                                ? () {
                                    context.read<GameBloc>().add(
                                        SubmitTextEvent(
                                            text: _controller.text));
                                  }
                                : null,
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
