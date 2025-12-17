import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;
import 'package:nuliga_app/model/match_result_detail.dart';

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

    final MS1 = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "1.HE")
          .single,
    );

    final MS2 = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "2.HE")
          .first,
    );
    final MS3 = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "3.HE")
          .first,
    );
    final WS = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "DE")
          .first,
    );
    final MD1 = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "1.HD")
          .first,
    );
    final MD2 = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "2.HD")
          .first,
    );
    final WD = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "DD")
          .first,
    );
    final XD = getGameResult(
      filledListOfListOfCells
          .where((cells) => cells[0].text.trim() == "GD")
          .first,
    );

    return MatchResultDetail(
      MS1: MS1,
      MS2: MS2,
      MS3: MS3,
      MD1: MD1,
      MD2: MD2,
      WS: WS,
      XD: XD,
      WD: WD,
    );
  }

  GameResult getGameResult(List<Element> cells) {
    final result = GameResult(
      homePlayerNames: cells[1]
          .querySelectorAll('a')
          .map((a) => a.text.trim())
          .toList(),
      opponentPlayerNames: cells[2]
          .querySelectorAll('a')
          .map((a) => a.text.trim())
          .toList(),
      sets: cells
          .sublist(3, 6)
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .map((cellText) => SetResult.fromString(cellText))
          .toList(),
    );
    return result;
  }
}
