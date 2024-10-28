import 'package:chronicle/core/theme/app_colors.dart';
import 'package:chronicle/core/ui/widgets/circle_user_avatar.dart';
import 'package:chronicle/core/utils/string_utils.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_state.dart';
import 'package:chronicle/features/game/domain/model/game_model.dart';
import 'package:chronicle/features/game/domain/model/participant_model.dart';
import 'package:chronicle/features/home/presentation/widget/pill_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameWidget extends StatelessWidget {
  final GameModel gameModel;

  final Function(GameModel)? onTap;

  GameWidget({required this.gameModel, this.onTap, super.key});

  final BorderRadius borderRadius = BorderRadius.circular(17);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: () {
          onTap?.call(gameModel);
        },
        borderRadius: borderRadius,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    gameModel.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Spacer(),
                  _buildParticipants(context, gameModel.participants ?? []),
                  const SizedBox(
                    width: 10,
                  ),
                  if (!gameModel.isFinished)
                    Row(
                      children: [
                        Text(
                            'Round ${gameModel.currentRound}/${gameModel.maxRounds}'),
                        const SizedBox(
                          width: 15,
                        ),
                        PillContainer(
                          text: gameModel.phase.name.toCapitalized,
                        )
                      ],
                    ),
                ],
              ),

              if (gameModel.history?.isNotEmpty ?? false)
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      gameModel.history!.map((e) => e.text).join('\n'),
                      maxLines: 2,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildParticipants(
    BuildContext context, List<ParticipantModel> participants) {
  return BlocBuilder<UserBloc, UserState>(
    builder: (context, state) {
      var participantsWithoutUser =
          participants.where((p) => p.id != state.userModel!.id).take(3).toList();

      return SizedBox(
        height: 30,
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 5,
            );
          },
          itemBuilder: (context, index) {
            return CircleUserAvatar(
                width: 30,
                height: 30,
                url: participantsWithoutUser[index].photoUrl);
          },
          shrinkWrap: true,
          itemCount: participantsWithoutUser.length,
          scrollDirection: Axis.horizontal,
        ),
      );
    },
  );
}
