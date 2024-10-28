abstract class HomeEvent {

}

class CheckGameByCodeEvent extends HomeEvent{
  final String gameCode;

  CheckGameByCodeEvent({required this.gameCode});
}

class GetActiveGamesEvent extends HomeEvent{

}

class GetCompletedGamesEvent extends HomeEvent{

}