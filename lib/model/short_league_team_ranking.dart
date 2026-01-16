class ShortLeagueTeamRanking {
  final int rank;
  final int wins;
  final String teamName;
  final String teamUrl;
  final int totalTeams;
  final String leagueName;
  final int playedMatches;

  ShortLeagueTeamRanking({
    required this.rank,
    required this.wins,
    required this.playedMatches,
    required this.teamName,
    required this.teamUrl,
    required this.totalTeams,
    required this.leagueName,
  });

  static ShortLeagueTeamRanking empty = ShortLeagueTeamRanking(
    rank: 0,
    wins: 0,
    playedMatches: 0,
    teamName: "",
    teamUrl: "",
    totalTeams: 0,
    leagueName: "",
  );
}
