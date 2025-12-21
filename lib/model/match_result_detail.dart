// ignore_for_file: non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:nuliga_app/services/shared/parser.dart';

class MatchResultDetail {
  final GameResult MS1;
  final GameResult MS2;
  final GameResult MS3;
  final GameResult MD1;
  final GameResult MD2;
  final GameResult WS;
  final GameResult XD;
  final GameResult WD;

  MatchResultDetail({
    required this.MS1,
    required this.MS2,
    required this.MS3,
    required this.MD1,
    required this.MD2,
    required this.WS,
    required this.XD,
    required this.WD,
  });
}

class Player {
  final String firstName;
  final String lastName;

  Player({required this.firstName, required this.lastName});

  factory Player.fromCommaSeparatedString(String name) {
    final nameParts = name.split(",");

    if (nameParts.length < 2) {
      print("Cannot parse name");
      return Player(firstName: "Unknown", lastName: "Unknown");
    }

    return Player(firstName: nameParts[1], lastName: nameParts[0]);
  }

  String getFullname() {
    return "$firstName $lastName";
  }
}

class GameResult {
  final List<Player> homePlayers;
  final List<Player> opponentPlayers;
  final List<SetResult> sets;
  late final int homeSetsWon = _getHomeSetsWon();
  late final int opponentSetsWon = _getOpponentSetsWon();
  late final bool homeTeamWon = homeSetsWon > opponentSetsWon;

  GameResult({
    required this.homePlayers,
    required this.opponentPlayers,
    required this.sets,
  });

  int _getHomeSetsWon() {
    return sets.where((set) => set.homeScore > set.opponentScore).length;
  }

  int _getOpponentSetsWon() {
    return sets.where((set) => set.homeScore < set.opponentScore).length;
  }
}

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
}
