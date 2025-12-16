// ignore_for_file: non_constant_identifier_names
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

class GameResult {
  final List<String> homePlayerNames;
  final List<String> opponentPlayerNames;
  final List<SetResult> sets;
  late final int homeSetsWon = _getHomeSetsWon();
  late final int opponentSetsWon = _getOpponentSetsWon();

  GameResult({
    required this.homePlayerNames,
    required this.opponentPlayerNames,
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

  SetResult({required this.homeScore, required this.opponentScore});
}
