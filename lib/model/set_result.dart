// ignore_for_file: non_constant_identifier_names

import 'package:nuliga_app/services/shared/parser.dart';

class SetResult {
  final int homeScore;
  final int opponentScore;

  static final NullResult = SetResult(homeScore: 0, opponentScore: 0);

  factory SetResult.fromString(String setResultString) {
    final splitText = setResultString.split(":");
    if (splitText.length < 2) return NullResult;

    final homeScore = Parser.convertToIntOrZero(splitText[0]);
    final opponentScore = Parser.convertToIntOrZero(splitText[1]);
    return SetResult(homeScore: homeScore, opponentScore: opponentScore);
  }

  SetResult({required this.homeScore, required this.opponentScore});

  bool didHomeTeamWin() {
    return homeScore > opponentScore;
  }

  bool didOpponentTeamWin() {
    return homeScore < opponentScore;
  }
}
