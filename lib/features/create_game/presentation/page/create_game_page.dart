import 'package:chronicle/core/theme/app_colors.dart';
import 'package:chronicle/core/ui/widgets/default_button.dart';
import 'package:chronicle/core/ui/widgets/default_text_field.dart';
import 'package:chronicle/features/create_game/presentation/bloc/create_game_bloc.dart';
import 'package:chronicle/features/create_game/presentation/bloc/create_game_event.dart';
import 'package:chronicle/features/create_game/presentation/bloc/create_game_state.dart';
import 'package:chronicle/features/create_game/presentation/widgets/number_picker.dart';
import 'package:chronicle/features/game/presentation/page/game_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({super.key});

  static const String route = '/create_game';

  @override
  State<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  String title = '';
  int rounds = 3;
  int roundDuration = 3;
  int votingDuration = 2;
  int maximumParticipants = 3;

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
      title: Row(
        children: [
          IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.chevron_left)),
          Text(
            'Create game',
            style: Theme.of(context).textTheme.headlineMedium,
          )
        ],
      ),
      titleSpacing: 0,
      toolbarHeight: 60,
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<CreateGameBloc, CreateGameState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTextField(
                    hintText: 'Enter story title',
                    borderRadius: BorderRadius.circular(12),
                    minLines: 1,
                    maxLines: 1,
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Rounds',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            NumberPicker(
              from: 3,
              to: 10,
              onNumberChanged: (value) {
                setState(() {
                  rounds = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'Round duration (minutes)',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            NumberPicker(
              from: 3,
              to: 10,
              onNumberChanged: (value) {
                setState(() {
                  roundDuration = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'Voting duration (minutes)',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            NumberPicker(
              from: 2,
              to: 10,
              onNumberChanged: (value) {
                setState(() {
                  votingDuration = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'Maximum participants',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            NumberPicker(
              from: 3,
              to: 10,
              onNumberChanged: (value) {
                maximumParticipants = value;
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: DefaultButton(
                text: 'Create',
                onPressed: title.isEmpty
                    ? null
                    : () {
                        context.read<CreateGameBloc>().add(CreateGameEvent(
                            title: title,
                            rounds: rounds,
                            roundDuration: roundDuration,
                            votingDuration: votingDuration,
                            maximumParticipants: maximumParticipants));
                      },
                backgroundColor: AppColors.secondary,
                textColor: AppColors.textColor,
              ),
            )
          ],
        );
      },
      listener: (context, state) {
        if(state.status == CreateGameStatus.success){
          if(state.createdGameCode!=null){
            context.go(GamePage.route(state.createdGameCode!));
          }
        }
      },
    );
  }
}
