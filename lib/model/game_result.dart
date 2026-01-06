// ignore_for_file: non_constant_identifier_names

import 'package:nuliga_app/model/game_type.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/model/player.dart';
import 'package:nuliga_app/model/set_result.dart';

class GameResult {
  final List<Player> homePlayers;
  final List<Player> opponentPlayers;
  final List<SetResult> sets;
  final GameType gameType;
  late final int homeSetsWon = _getHomeSetsWon();
  late final int opponentSetsWon = _getOpponentSetsWon();
  late final bool homeTeamWon = homeSetsWon > opponentSetsWon;

  GameResult({
    required this.homePlayers,
    required this.opponentPlayers,
    required this.sets,
    required this.gameType,
  });

  int _getHomeSetsWon() {
    return sets.where((set) => set.homeScore > set.opponentScore).length;
  }

  int _getOpponentSetsWon() {
    return sets.where((set) => set.homeScore < set.opponentScore).length;
  }

  MatchResultStatus getMatchStatusForHomeTeam() {
    return homeTeamWon ? MatchResultStatus.Win : MatchResultStatus.Loss;
  }

  MatchResultStatus getMatchStatusForOpponentTeam() {
    return !homeTeamWon ? MatchResultStatus.Win : MatchResultStatus.Loss;
  }
}
