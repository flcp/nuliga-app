import 'dart:developer' as developer;

import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/shared/parser.dart';
import 'package:nuliga_app/services/shared/table_parser.dart';

class NextMatchesParser {
  final tableParser = MatchesTableParser();

  List<FutureMatch> getEntriesAsFutureMatches(
    String htmlContent,
    String baseUrl,
  ) {
    final rows = tableParser.getTableRows(htmlContent);

    if (rows.isEmpty) {
      developer.log("No rows in next matches overview", level: 800);
      return [];
    }

    final tableIndizes = tableParser.getTableIndizesFromHeaderRow(rows);
    final dataRows = tableParser.getDataRows(rows);

    final List<FutureMatch> result = [];

    for (int i = 0; i < dataRows.length; i++) {
      final cells = dataRows[i];

      if (i > 0 && cells[tableIndizes.dateIndex].text.trim().isEmpty) {
        final cellsOfLastRow = dataRows[i - 1];
        cells[tableIndizes.dateIndex].text =
            cellsOfLastRow[tableIndizes.dateIndex].text;
      }

      // TODO: use parser helper function
      final dateTime = Parser.getMatchDateTime(
        cells[tableIndizes.dateIndex],
        cells[tableIndizes.timeIndex],
      );

      final locationUrl = Parser.getLinkOrEmpty(
        cells,
        tableIndizes.locationIndex,
        baseUrl,
      );

      result.add(
        FutureMatch(
          time: dateTime,
          locationUrl: locationUrl,
          homeTeam: Parser.getCellOrEmpty(cells, tableIndizes.homeTeamIndex),
          opponentTeam: Parser.getCellOrEmpty(
            cells,
            tableIndizes.opponentTeamIndex,
          ),
        ),
      );
    }
    return result;
  }
}
