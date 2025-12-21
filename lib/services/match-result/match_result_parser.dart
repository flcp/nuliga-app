import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;
import 'package:nuliga_app/model/game_result.dart';
import 'package:nuliga_app/model/game_type.dart';
import 'package:nuliga_app/model/match_result_detail.dart';
import 'package:nuliga_app/model/player.dart';
import 'package:nuliga_app/model/set_result.dart';

class MatchResultParser {
  Future<MatchResultDetail> getGamesAndResults(String htmlContent) async {
    if (htmlContent.trim().isEmpty) {
      // TODO: fix, make whole file robust
      print("htmlcontent empty");
      throw ("htmlcontent empty");
    }

    final document = html.parse(htmlContent);

    final rows = document.querySelectorAll('table.result-set tr').skip(1);

    final listOfListOfCells = rows.map((row) => row.querySelectorAll('td'));

    final filledListOfListOfCells = listOfListOfCells.where(
      (cells) => cells.length > 6,
    );

    final ms1 = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "1.HE")
          .single,
    );

    final ms2 = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "2.HE")
          .first,
    );
    final ms3 = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "3.HE")
          .first,
    );
    final ws = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "DE")
          .first,
    );
    final md1 = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "1.HD")
          .first,
    );
    final md2 = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "2.HD")
          .first,
    );
    final wd = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "DD")
          .first,
    );
    final xd = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "GD")
          .first,
    );

    return MatchResultDetail(
      gameResults: [ws, wd, xd, ms1, ms2, ms3, md1, md2],
    );
  }

  GameResult getGameResult(List<Element> cells) {
    final homePlayers = cells[1]
        .querySelectorAll('a')
        .map((a) => a.text.trim())
        .map((playerName) => Player.fromCommaSeparatedString(playerName))
        .toList();
    final opponentPlayers = cells[2]
        .querySelectorAll('a')
        .map((a) => a.text.trim())
        .map((playerName) => Player.fromCommaSeparatedString(playerName))
        .toList();

    final type = GameType.getGameType(cells[0].text.trim());

    final result = GameResult(
      homePlayers: homePlayers,
      opponentPlayers: opponentPlayers,
      sets: cells
          .sublist(3, 6)
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .map((cellText) => SetResult.fromString(cellText))
          .toList(),
      gameType: type,
    );
    return result;
  }
}
