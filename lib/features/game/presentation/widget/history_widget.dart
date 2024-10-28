import 'package:chronicle/core/ui/widgets/circle_user_avatar.dart';
import 'package:chronicle/features/game/presentation/bloc/game_bloc.dart';
import 'package:chronicle/features/game/presentation/bloc/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              var fragment = state.history![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleUserAvatar(width: 30, height: 30, url: fragment.author.photoUrl),
                      const SizedBox(width: 5,),
                      Text(fragment.author.name,style: Theme.of(context).textTheme.bodyMedium,)
                    ],
                  ),
                  Text(fragment.text,style: Theme.of(context).textTheme.bodyLarge,)
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: state.history?.length ?? 0,shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),);
      },
    );
  }
}
