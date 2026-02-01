import 'dart:developer' as developer;

import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;
import 'package:nuliga_app/services/match-result/model/game_result.dart';
import 'package:nuliga_app/services/match-result/model/game_type.dart';
import 'package:nuliga_app/services/match-result/model/match_result_detail.dart';
import 'package:nuliga_app/services/match-result/model/player.dart';
import 'package:nuliga_app/services/match-result/model/set_result.dart';

class MatchResultParser {
  Future<MatchResultDetail> getGamesAndResults(String htmlContent) async {
    if (htmlContent.trim().isEmpty) {
      developer.log("Empty html received in matches overview", level: 800);
      return MatchResultDetail(gameResults: []);
    }

    // TODO: make whole file robust

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
    final homePlayers = getPlayerNamesFromLinks(cells, 1);
    final opponentPlayers = getPlayerNamesFromLinks(cells, 2);
    final sets = getSets(cells, 3, 6, homePlayers, opponentPlayers);

    final type = GameType.getGameType(cells[0].text.trim());

    final result = GameResult(
      homePlayers: homePlayers,
      opponentPlayers: opponentPlayers,
      sets: sets,
      gameType: type,
    );
    return result;
  }

  List<Player> getPlayerNamesFromLinks(List<Element> cells, int i) {
    if (cells.length < i) {
      return [Player.unknown];
    }

    final cell = cells[i];
    if (cell.text.isEmpty) {
      return [Player.unknown];
    }

    if (cell.text.trim().contains("nicht angetreten") ||
        cell.text.trim().contains("nicht anwesend")) {
      return [Player.absent];
    }

    return cell
        .querySelectorAll('a')
        .map((a) => a.text.trim())
        .map((playerName) => Player.fromCommaSeparatedString(playerName))
        .toList();
  }

  List<SetResult> getSets(
    List<Element> cells,
    int i,
    int j,
    List<Player> homePlayers,
    List<Player> opponentPlayers,
  ) {
    if (homePlayers.contains(Player.absent)) {
      return [
        SetResult(homeScore: 0, opponentScore: 21),
        SetResult(homeScore: 0, opponentScore: 21),
      ];
    }

    if (opponentPlayers.contains(Player.absent)) {
      return [
        SetResult(homeScore: 21, opponentScore: 0),
        SetResult(homeScore: 21, opponentScore: 0),
      ];
    }

    return cells
        .sublist(3, 6)
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .map((cellText) => SetResult.fromString(cellText))
        .toList();
  }
}
