import 'package:chronicle/features/auth/presentation/pages/auth_page.dart';
import 'package:chronicle/features/create_game/presentation/page/create_game_page.dart';
import 'package:chronicle/features/game/presentation/page/game_page.dart';
import 'package:chronicle/features/home/presentation/page/home_page.dart';
import 'package:chronicle/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static var router = GoRouter(initialLocation: SplashPage.route, routes: [
    GoRoute(
        path: SplashPage.route,
        builder: (context, state) {
          return const SplashPage();
        }),
    GoRoute(
        path: AuthPage.route,
        builder: (context, state) {
          return const AuthPage();
        }),
    GoRoute(
        path: HomePage.route,
        builder: (context, state) {
          return const HomePage();
        },
        routes: [
          GoRoute(
              path: 'game/:id',
              builder: (context, state) {
                return GamePage(gameCode: state.pathParameters['id'] ?? '');
              })
        ]),
    GoRoute(
        path: CreateGamePage.route,
        builder: (context, state) {
          return const CreateGamePage();
        })
  ]);
}
