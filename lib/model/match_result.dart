class MatchResult {
  final DateTime time;
  final String homeTeamName;
  final String opponentTeamName;
  final String location;
  final int homeTeamMatchesWon;
  final int opponentTeamMatchesWon;
  final String resultDetailUrl;

  MatchResult({
    required this.time,
    required this.homeTeamName,
    required this.opponentTeamName,
    required this.location,
    required this.homeTeamMatchesWon,
    required this.opponentTeamMatchesWon,
    required this.resultDetailUrl,
  });

  MatchResultStatus getMatchStatusForTeam(String teamName) {
    if (homeTeamMatchesWon == opponentTeamMatchesWon) {
      return MatchResultStatus.Draw;
    }

    if (isHomeTeam(teamName)) {
      return didHomeTeamWin() ? MatchResultStatus.Win : MatchResultStatus.Loss;
    }

    if (isOpponentTeam(teamName)) {
      return didOpponentTeamWin()
          ? MatchResultStatus.Win
          : MatchResultStatus.Loss;
    }

    return MatchResultStatus.Unknown;
  }

  bool isHomeTeam(String teamName) {
    return homeTeamName == teamName;
  }

  bool isOpponentTeam(String teamName) {
    return opponentTeamName == teamName;
  }

  bool didHomeTeamWin() {
    return homeTeamMatchesWon > opponentTeamMatchesWon;
  }

  bool didOpponentTeamWin() {
    return opponentTeamMatchesWon > homeTeamMatchesWon;
  }
}

enum MatchResultStatus { Win, Loss, Draw, Unknown }
