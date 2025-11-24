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

    // Skip header row (first)
    final dataRows = rows.skip(1);

    final List<TeamStanding> result = [];

    for (final row in dataRows) {
      final cells = row.querySelectorAll('td');
      if (cells.length < 10) continue; // Skip empty or malformed rows

      final rank = int.parse(cells[1].text.trim());

      final teamName = cells[2].querySelector('a')?.text.trim() ?? '';
      final teamUrl = cells[2].querySelector('a')?.attributes['href'] ?? '';

      final leaguePointsWon = int.parse(cells[7].text.trim().split(":")[0]);

      final gamesWon = int.parse(cells[8].text.trim().split(":")[0]);
      final gamesLost = int.parse(cells[8].text.trim().split(":")[1]);

      final setsWon = int.parse(cells[9].text.trim().split(":")[0]);
      final setsLost = int.parse(cells[9].text.trim().split(":")[1]);

      result.add(
        TeamStanding(
          rank: rank,
          teamName: teamName,
          teamUrl: teamUrl,
          totalMatches: int.parse(cells[3].text.trim()),
          wins: int.parse(cells[4].text.trim()),
          draws: int.parse(cells[5].text.trim()),
          losses: int.parse(cells[6].text.trim()),
          leaguePointsWon: leaguePointsWon,
          gamesWon: gamesWon,
          gamesLost: gamesLost,
          setsWon: setsWon,
          setsLost: setsLost
        ),
      );
    }

    return result;
  }
}
