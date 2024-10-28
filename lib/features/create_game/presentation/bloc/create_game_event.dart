class CreateGameEvent {
  final String title;
  final int rounds;
  final int roundDuration;
  final int votingDuration;
  final int maximumParticipants;

  CreateGameEvent(
      {required this.title,
      required this.rounds,
      required this.roundDuration,
      required this.votingDuration,
      required this.maximumParticipants});
}
