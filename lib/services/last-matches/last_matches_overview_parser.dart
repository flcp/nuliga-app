import 'dart:developer' as developer;

import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/services/shared/parser.dart';
import 'package:nuliga_app/services/shared/table_parser.dart';

class LastMatchesOverviewParser {
  final tableParser = TableParser();

  List<MatchResult> getMatchResultEntries(String htmlContent, String baseUrl) {
    final rows = tableParser.getTableRows(htmlContent);
    if (rows.isEmpty) {
      developer.log("No rows in last matches overview", level: 800);
      return [];
    }

    final tableIndizes = tableParser.getTableIndizesFromHeaderRow(rows);
    final dataRows = tableParser.getDataRows(rows);

    final List<MatchResult> result = [];

    for (int i = 0; i < dataRows.length; i++) {
      final cells = dataRows[i];

      if (cells[tableIndizes.resultIndex].text.trim().isEmpty) continue;

      if (i > 0 && cells[tableIndizes.dateIndex].text.trim().isEmpty) {
        cells[tableIndizes.dateIndex].text =
            dataRows[i - 1][tableIndizes.dateIndex].text;
      }

      // TODO: use parser helper function
      final dateTime = Parser.getMatchDateTime(
        cells[tableIndizes.dateIndex],
        cells[tableIndizes.timeIndex],
      );

      final resultDetailUrl = Parser.getLinkOrEmpty(
        cells,
        tableIndizes.resultIndex,
        baseUrl,
      );

      final locationUrl = Parser.getLinkOrEmpty(
        cells,
        tableIndizes.locationIndex,
        baseUrl,
      );

      result.add(
        MatchResult(
          homeTeamName: Parser.getCellOrEmpty(
            cells,
            tableIndizes.homeTeamIndex,
          ),
          opponentTeamName: Parser.getCellOrEmpty(
            cells,
            tableIndizes.opponentTeamIndex,
          ),
          homeTeamMatchesWon: Parser.getCellTupleOrZero(
            cells,
            tableIndizes.resultIndex,
          )[0],
          opponentTeamMatchesWon: Parser.getCellTupleOrZero(
            cells,
            tableIndizes.resultIndex,
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
