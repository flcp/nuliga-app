import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;
import 'package:nuliga_app/model/league_team_ranking.dart';
import 'package:nuliga_app/services/shared/parser.dart';

class LeagueParser {
  static List<LeagueTeamRanking> parseLeagueTable(String htmlContent) {
    if (htmlContent.trim().isEmpty) {
      return [];
    }

    final document = html.parse(htmlContent);

    final table = document.querySelector('table.${Parser.tableClass}');
    if (table == null) {
      return [];
    }

    final rows = table.querySelectorAll('tr');
    if (rows.isEmpty) {
      return [];
    }

    final dataRows = rows.skip(1);
    final List<LeagueTeamRanking> result = [];

    for (final row in dataRows) {
      final cells = row.querySelectorAll('td');

      result.add(
        LeagueTeamRanking(
          rank: Parser.getCellOrZero(cells, 1),
          teamName: _getTeamname(cells),
          teamUrl: _getTeamUrl(cells),
          totalMatches: Parser.getCellOrZero(cells, 3),
          wins: Parser.getCellOrZero(cells, 4),
          draws: Parser.getCellOrZero(cells, 5),
          losses: Parser.getCellOrZero(cells, 6),
          leaguePointsWon: Parser.getCellTupleOrZero(cells, 7)[0],
          gamesWon: Parser.getCellTupleOrZero(cells, 8)[0],
          gamesLost: Parser.getCellTupleOrZero(cells, 8)[1],
          setsWon: Parser.getCellTupleOrZero(cells, 9)[0],
          setsLost: Parser.getCellTupleOrZero(cells, 9)[1],
        ),
      );
    }

    return result;
  }

  static String _getTeamname(List<Element> cells) {
    final href = _getTeamLinkElement(cells);
    return href?.text.trim() ?? "??";
  }

  static String _getTeamUrl(List<Element> cells) {
    final href = _getTeamLinkElement(cells);
    return href?.attributes['href'] ?? "??";
  }

  static Element? _getTeamLinkElement(List<Element> cells) {
    final index = 2;
    if (cells.length < index) return null;

    return cells[index].querySelector('a');
  }
}
