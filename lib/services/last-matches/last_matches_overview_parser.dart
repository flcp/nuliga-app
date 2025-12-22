import 'package:html/parser.dart' as html;
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/services/shared/parser.dart';

class LastMatchesOverviewParser {
  List<MatchResult> getMatchResultEntries(String htmlContent, String baseUrl) {
    if (htmlContent.trim().isEmpty) {
      print("htmlcontent empty");
      return [];
    }

    final document = html.parse(htmlContent);

    final table = document.querySelector('table.${Parser.tableClass}');

    if (table == null) {
      print("table not found");
      return [];
    }

    final rows = table.querySelectorAll('tr');
    if (rows.isEmpty) {
      print("table found, but no rows");
      return [];
    }

    final dataRows = rows.skip(1).toList();
    final List<MatchResult> result = [];

    for (int i = 0; i < dataRows.length; i++) {
      final row = dataRows[i];
      final cells = row.querySelectorAll('td');

      if (cells.length < 7) {
        print("could not find all info, skipping row");
        continue;
      }

      if (cells[Parser.matchesResultIndex].text.trim().isEmpty) continue;

      if (i > 0 && cells[Parser.matchesDateIndex].text.trim().isEmpty) {
        cells[Parser.matchesDateIndex].text = dataRows[i - 1]
            .querySelectorAll('td')[Parser.matchesDateIndex]
            .text;
      }

      // TODO: use parser helper function
      final dateTime = Parser.getMatchDateTime(
        cells[Parser.matchesDateIndex],
        cells[Parser.matchesTimeIndex],
      );

      final resultDetailUrl = Parser.getLinkOrEmpty(
        cells,
        Parser.matchesResultIndex,
        baseUrl,
      );

      final locationUrl = Parser.getLinkOrEmpty(
        cells,
        Parser.matchesLocationIndex,
        baseUrl,
      );

      result.add(
        MatchResult(
          homeTeamName: Parser.getCellOrEmpty(
            cells,
            Parser.matchesHomeTeamIndex,
          ),
          opponentTeam: Parser.getCellOrEmpty(
            cells,
            Parser.matchesOpponentTeamIndex,
          ),
          homeTeamMatchesWon: Parser.getCellTupleOrZero(
            cells,
            Parser.matchesResultIndex,
          )[0],
          opponentTeamMatchesWon: Parser.getCellTupleOrZero(
            cells,
            Parser.matchesResultIndex,
          )[1],
          location: locationUrl,
          time: dateTime,
          resultDetailUrl: resultDetailUrl,
        ),
      );
    }
    return result;
  }
}
