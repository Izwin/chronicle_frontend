
import 'package:chronicle/core/theme/app_colors.dart';
import 'package:chronicle/core/ui/widgets/circle_user_avatar.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_state.dart';
import 'package:chronicle/features/game/presentation/bloc/game_bloc.dart';
import 'package:chronicle/features/game/presentation/bloc/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VotingWidget extends StatefulWidget {
  final Function(String) onSelected;
  const VotingWidget({required this.onSelected,super.key});

  @override
  State<VotingWidget> createState() => _VotingWidgetState();
}

class _VotingWidgetState extends State<VotingWidget> {
  String? selectedFragmentAuthorId;

  final BorderRadius borderRadius = const BorderRadius.only(
    topRight: Radius.circular(12),
    topLeft: Radius.circular(2),
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            // You can not vote for yourself.

            var participants = state.participants
                    ?.where((p) => true)
                    .toList() ??
                [];

            return ListView.separated(
              itemBuilder: (context, index) {
                var participant = participants[index];

                return Row(
                  children: [
                    CircleUserAvatar(
                        width: 30, height: 30, url: participant.photoUrl),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          participant.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Material(
                          color: selectedFragmentAuthorId == participant.id
                              ? AppColors.primary
                              : AppColors.surface,
                          borderRadius: borderRadius,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedFragmentAuthorId = participant.id;
                                widget.onSelected.call(participant.id);
                              });
                            },
                            borderRadius: borderRadius,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                '${participant.text}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: selectedFragmentAuthorId ==
                                              participant.id
                                          ? AppColors.surface
                                          : AppColors.textColor,
                                    ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
                  ],
                );
              },
              separatorBuilder: (context,index){
                return const SizedBox(height: 10,);
              },
              itemCount: participants.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            );
          },
        );
      },
    );
  }
}
