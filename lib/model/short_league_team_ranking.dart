class ShortLeagueTeamRanking {
  final int rank;
  final String teamName;
  final String teamUrl;
  final int totalTeams;
  final String leagueName;

  ShortLeagueTeamRanking({
    required this.rank,
    required this.teamName,
    required this.teamUrl,
    required this.totalTeams, 
    required this.leagueName,
  });

  static ShortLeagueTeamRanking empty = ShortLeagueTeamRanking(
    rank: 0,
    teamName: "",
    teamUrl: "",
    totalTeams: 0,
    leagueName: "",
  );

}
