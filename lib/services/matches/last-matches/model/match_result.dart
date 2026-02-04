import 'package:flutter/material.dart';
import 'package:nuliga_app/l10n/app_localizations.dart';

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
      return MatchResultStatus.draw;
    }

    if (isHomeTeam(teamName)) {
      return didHomeTeamWin() ? MatchResultStatus.win : MatchResultStatus.loss;
    }

    if (isOpponentTeam(teamName)) {
      return didOpponentTeamWin()
          ? MatchResultStatus.win
          : MatchResultStatus.loss;
    }

    return MatchResultStatus.unknown;
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

enum MatchResultStatus { win, loss, draw, unknown }

extension MatchResultStatusExtension on MatchResultStatus {
  String localized(BuildContext context) {
    switch (this) {
      case MatchResultStatus.win:
        return AppLocalizations.of(context)!.matchResultWin;
      case MatchResultStatus.loss:
        return AppLocalizations.of(context)!.matchResultLoss;
      case MatchResultStatus.draw:
        return AppLocalizations.of(context)!.matchResultDraw;
      case MatchResultStatus.unknown:
        return AppLocalizations.of(context)!.matchResultUnknown;
    }
  }
}
