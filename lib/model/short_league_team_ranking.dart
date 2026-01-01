class ShortLeagueTeamRanking {
  final int rank;
  final String teamName;
  final String teamUrl;
  final int totalTeams;

  ShortLeagueTeamRanking({
    required this.rank,
    required this.teamName,
    required this.teamUrl,
    required this.totalTeams, 
  });

  static ShortLeagueTeamRanking empty = ShortLeagueTeamRanking(
    rank: 0,
    teamName: "",
    teamUrl: "",
    totalTeams: 0,
  );
}
