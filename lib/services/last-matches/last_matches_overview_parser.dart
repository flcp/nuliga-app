import 'dart:developer' as developer;

import 'package:html/parser.dart' as html;
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/services/shared/parser.dart';
import 'package:nuliga_app/services/shared/tableheader_parser.dart';

class LastMatchesOverviewParser {
  List<MatchResult> getMatchResultEntries(String htmlContent, String baseUrl) {
    if (htmlContent.trim().isEmpty) {
      developer.log("Empty html received in matches overview", level: 800);

      return [];
    }

    final document = html.parse(htmlContent);

    final table = document.querySelector('table.${Parser.tableClass}');

    if (table == null) {
      developer.log("Matches table not found", level: 800);

      return [];
    }

    final rows = table.querySelectorAll('tr');
    if (rows.isEmpty) {
      developer.log("No rows in matches table", level: 800);
      return [];
    }

    final dataRows = rows
        .map((row) => row.querySelectorAll('td'))
        .where((cells) => cells.isNotEmpty)
        .toList();

    final headerRow = rows.first.querySelectorAll('th');
    final tableIndizes = TableheaderParser.getIndices(headerRow);

    final List<MatchResult> result = [];

    for (int i = 0; i < dataRows.length; i++) {
      final cells = dataRows[i];

      if (cells.length < 7) {
        developer.log("could not find all info, skipping row", level: 800);
        continue;
      }

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
