class FutureMatch {
  DateTime time;
  String homeTeam;
  String opponentTeam;
  String locationUrl;

  FutureMatch({
    required this.time,
    required this.homeTeam,
    required this.opponentTeam,
    this.locationUrl = "",
  });
}
