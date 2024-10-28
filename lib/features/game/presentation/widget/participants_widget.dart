import 'package:chronicle/core/theme/app_colors.dart';
import 'package:chronicle/core/ui/widgets/circle_user_avatar.dart';
import 'package:chronicle/core/utils/game_utils.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_state.dart';
import 'package:chronicle/features/game/domain/model/game_phase.dart';
import 'package:chronicle/features/game/domain/model/participant_model.dart';
import 'package:chronicle/features/game/presentation/bloc/game_bloc.dart';
import 'package:chronicle/features/game/presentation/bloc/game_event.dart';
import 'package:chronicle/features/game/presentation/bloc/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParticipantsWidget extends StatelessWidget {
  const ParticipantsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Participants',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  Text(
                    '${state.participants?.length}/${state.maximumParticipants}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                itemBuilder: (context, index) {
                  var participant = state.participants![index];
                  return Row(
                    children: [
                      CircleUserAvatar(
                          width: 40, height: 40, url: participant.photoUrl),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        participant.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500, height: 1),
                      ),
                      const SizedBox(width: 5,),
                      buildStatus(context, participant), 
                      const Spacer(),
                      buildButton(context, participant)
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: state.participants?.length ?? 0,
                shrinkWrap: true,
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildButton(BuildContext context, ParticipantModel participant) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
          if (participant.isCreator) {
            return Text(
              'Creator',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.primary),
            );
          }
          if (state.gamePhase == GamePhase.canceled ||
              state.gamePhase == GamePhase.finished) {
            return Container();
          }
          if (GameUtils.isCreator(
              userState.userModel!, state.participants ?? [])) {
            return IconButton(
              icon: const Icon(
                Icons.remove_circle_outline,
              ),
              onPressed: () {
                context
                    .read<GameBloc>()
                    .add(KickParticipantEvent(userId: participant.id));
              },
            );
          }
          return Container();
        });
      },
    );
  }

  Widget buildStatus(BuildContext context, ParticipantModel participant) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if ([
          GamePhase.waiting,
          GamePhase.canceled,
          GamePhase.finished,
        ].contains(state.gamePhase)) {
          return Container();
        }

        return Icon(
            participant.hasSubmitted ? Icons.done : Icons.timer_outlined);
      },
    );
  }
}
