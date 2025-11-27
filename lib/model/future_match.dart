class FutureMatch {
  DateTime time;
  String homeTeam;
  String opponentTeam;
  String location;

  // todo anderer konstruktor
  FutureMatch(
    this.time,
    this.homeTeam,
    this.opponentTeam, [
    this.location = "",
  ]);
}
