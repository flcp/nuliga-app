import 'package:nuliga_app/model/match_result_detail.dart';

class MatchResultService {
  static Future<MatchResultDetail> getMatchResultDetails(
    String resultDetailUrl,
  ) async {
    // TODO: actually implement
    final md1 = GameResult(
      homePlayerNames: ["Florian Pohl", "Yi Chian Chong"],
      opponentPlayerNames: ["Manuel Beinert", "Anxin Fang"],
      sets: [
        SetResult(homeScore: 10, opponentScore: 21),
        SetResult(homeScore: 15, opponentScore: 21),
      ],
    );

    return Future.value(
      MatchResultDetail(
        MD1: md1,
        MD2: md1,
        MS1: md1,
        MS2: md1,
        MS3: md1,
        WS: md1,
        XD: md1,
        WD: md1,
      ),
    );
  }
}
