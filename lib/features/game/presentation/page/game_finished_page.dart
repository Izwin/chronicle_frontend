import 'package:chronicle/core/theme/app_colors.dart';
import 'package:chronicle/core/ui/widgets/default_button.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_state.dart';
import 'package:chronicle/features/game/presentation/bloc/game_bloc.dart';
import 'package:chronicle/features/game/presentation/bloc/game_state.dart';
import 'package:chronicle/features/game/presentation/widget/history_widget.dart';
import 'package:chronicle/features/game/presentation/widget/participants_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class GameFinishedPage extends StatelessWidget {
  const GameFinishedPage({super.key});

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
                    'Completed',
                    style: Theme.of(context).textTheme.headlineMedium,
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
                        Text('${state.title}',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                        ),),
                        const SizedBox(height: 15,),
                        const HistoryWidget(),
                        const SizedBox(height: 15,),
                        const ParticipantsWidget(),
                        const SizedBox(height: 80,),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DefaultButton(
                  text: 'Share',
                  backgroundColor: AppColors.secondary,
                  textColor: AppColors.textColor,
                  onPressed: (){
                    var historyList = state.history?.map((e) => e.text).toList() ?? [];

                    var result = historyList.join('\n');

                    Share.share(result,subject: state.title ?? '');
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
