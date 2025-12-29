class LeagueTeamRanking {
  final int rank;
  final String teamName;
  final String teamUrl;

  final int totalMatches;
  final int wins;
  final int draws;
  final int losses;

  final int leaguePointsWon;
  final int gamesWon;
  final int gamesLost;

  final int setsWon;
  final int setsLost;

  LeagueTeamRanking({
    required this.rank,
    required this.teamName,
    required this.teamUrl,
    required this.totalMatches,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.leaguePointsWon,
    required this.gamesWon,
    required this.gamesLost,
    required this.setsWon,
    required this.setsLost,
  });

  static LeagueTeamRanking empty = LeagueTeamRanking(
    rank: 0,
    teamName: "",
    teamUrl: "",
    totalMatches: 0,
    wins: 0,
    draws: 0,
    losses: 0,
    leaguePointsWon: 0,
    gamesWon: 0,
    gamesLost: 0,
    setsWon: 0,
    setsLost: 0,
  );
}
