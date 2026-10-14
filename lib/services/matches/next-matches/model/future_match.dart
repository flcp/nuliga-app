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

  bool isHomeTeam(String teamName) {
    return homeTeam == teamName;
  }

  String getOpponent(String teamName) {
    assert(
      homeTeam == teamName || opponentTeam == teamName,
      "The provided team is not part of this match.",
    );

    return isHomeTeam(teamName) ? opponentTeam : homeTeam;
  }
}
