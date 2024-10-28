import 'package:chronicle/core/theme/app_colors.dart';
import 'package:chronicle/core/ui/widgets/circle_user_avatar.dart';
import 'package:chronicle/core/ui/widgets/default_button.dart';
import 'package:chronicle/core/ui/widgets/default_text_field.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_event.dart';
import 'package:chronicle/features/auth/presentation/bloc/user_state.dart';
import 'package:chronicle/features/create_game/presentation/page/create_game_page.dart';
import 'package:chronicle/features/game/presentation/page/game_page.dart';
import 'package:chronicle/features/home/presentation/bloc/home_bloc.dart';
import 'package:chronicle/features/home/presentation/bloc/home_event.dart';
import 'package:chronicle/features/home/presentation/bloc/home_state.dart';
import 'package:chronicle/features/home/presentation/widget/game_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildJoinGameSection(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Row(
            children: [
              CircleUserAvatar(
                  width: 50, height: 50, url: state.userModel?.photoUrl ?? ''),
              const SizedBox(
                width: 10,
              ),
              Text(
                state.userModel?.name ?? '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          );
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              onLogoutPressed(context);
            },
            icon: const Icon(Icons.logout))
      ],
    );
  }

  Widget _buildJoinGameSection(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == HomeStatus.successfullyCheckedGame) {
          if (state.gameModel != null) {
            controller.clear();
            context.go(GamePage.route(state.gameModel!.gameCode));
          }
        }
        if (state.status == HomeStatus.error || state.status == HomeStatus.checkGameError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${state.errorMessage}')));
        }

        if (state.status == HomeStatus.checkGameLoading) {
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                );
              });
        } else if (state.status == HomeStatus.successfullyCheckedGame || state.status == HomeStatus.checkGameError) {
          context.pop();
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Join via code',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultTextField(
                    hintText: 'Enter game code',
                    maxLines: 1,
                    actionIcon: IconButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          context
                              .read<HomeBloc>()
                              .add(CheckGameByCodeEvent(gameCode: controller.text));
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 30,
                      ),
                    ),
                    controller: controller,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'or',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultButton(
                    text: 'Create new game',
                    onPressed: () {
                      context.push(CreateGamePage.route);
                    },
                    backgroundColor: AppColors.secondary,
                    textColor: AppColors.textColor,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active games',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildActiveGames(context),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Completed games',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildCompletedGames(context)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedGames(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return GameWidget(gameModel: state.completedGames![index],onTap: (v){
                context.go(GamePage.route(v.gameCode));
              },);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10,);
            },
            itemCount: state.completedGames?.length ?? 0,shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),);
      },
    );
  }

  Widget _buildActiveGames(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return GameWidget(gameModel: state.activeGames![index],onTap: (v){
              context.go(GamePage.route(v.gameCode));
            },);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10,);
          },
          itemCount: state.activeGames?.length ?? 0,shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),);
      },
    );
  }

  void onLogoutPressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('No')),
              ElevatedButton(
                  onPressed: () {
                    context.read<UserBloc>().add(LogoutEvent());
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }
}
