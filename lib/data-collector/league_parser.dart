import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;
import 'package:nuliga_app/model/team_standing.dart';

/// Parses the HTML content and returns a list of [TeamStanding].
class LeagueParser {
  static const _tableClass = "result-set";

  static List<TeamStanding> parse(String htmlContent) {
    final document = html.parse(htmlContent);

    final table = document.querySelector('table.$_tableClass');
    if (table == null) {
      throw StateError('No table found with class "$_tableClass"');
    }

    final rows = table.querySelectorAll('tr');
    if (rows.isEmpty) {
      return [];
    }

    final dataRows = rows.skip(1);
    final List<TeamStanding> result = [];

    for (final row in dataRows) {
      final cells = row.querySelectorAll('td');

      result.add(
        TeamStanding(
          rank: getCellOrZero(cells, 1),
          teamName: getTeamname(cells),
          teamUrl: getTeamUrl(cells),
          totalMatches: getCellOrZero(cells, 3),
          wins: getCellOrZero(cells, 4),
          draws: getCellOrZero(cells, 5),
          losses: getCellOrZero(cells, 6),
          leaguePointsWon: getCellTupleOrZero(cells, 7)[0],
          gamesWon: getCellTupleOrZero(cells, 8)[0],
          gamesLost: getCellTupleOrZero(cells, 8)[1],
          setsWon: getCellTupleOrZero(cells, 9)[0],
          setsLost: getCellTupleOrZero(cells, 9)[1],
        ),
      );
    }

    return result;
  }

  static int getCellOrZero(List<Element> cells, int index) {
    final cell = getCellOrEmpty(cells, index);
    return convertToIntOrZero(cell);
  }

  static int convertToIntOrZero(String input) {
    final result = int.tryParse(input);

    if (result == null || result < 0) {
      return 0;
    }

    return result;
  }

  static String getCellOrEmpty(List<Element> cells, int index) {
    if (cells.length < index) return "";

    return cells[index].text.trim();
  }

  static String getTeamname(List<Element> cells) {
    final href = getTeamLinkElement(cells);
    return href?.text.trim() ?? "??";
  }

  static String getTeamUrl(List<Element> cells) {
    final href = getTeamLinkElement(cells);
    return href?.attributes['href'] ?? "??";
  }

  static Element? getTeamLinkElement(List<Element> cells) {
    final index = 2;
    if (cells.length < index) return null;

    return cells[index].querySelector('a');
  }

  static List<int> getCellTupleOrZero(List<Element> cells, int index) {
    // e.g. "9:1"
    final cell = getCellOrEmpty(cells, index);
    if (cell.isEmpty || !cell.contains(':')) return [0, 0];

    final numbers = cell.split(":");
    if (numbers.length < 2) return [0, 0];

    final firstNumber = convertToIntOrZero(numbers[0]);
    final secondNumber = convertToIntOrZero(numbers[1]);

    return [firstNumber, secondNumber];
  }
}
