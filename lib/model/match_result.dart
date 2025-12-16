class MatchResult {
  final DateTime time;
  final String homeTeam;
  final String opponentTeam;
  final String location;
  final int homeTeamMatchesWon;
  final int opponentTeamMatchesWon;
  final String resultDetailUrl;

  MatchResult({
    required this.time,
    required this.homeTeam,
    required this.opponentTeam,
    required this.location,
    required this.homeTeamMatchesWon,
    required this.opponentTeamMatchesWon,
    required this.resultDetailUrl,
  });
}
