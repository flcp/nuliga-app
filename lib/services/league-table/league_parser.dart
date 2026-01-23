import 'dart:developer' as developer;

import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;
import 'package:nuliga_app/model/league_team_ranking.dart';
import 'package:nuliga_app/services/shared/parser.dart';
import 'package:nuliga_app/services/shared/table_parser.dart';

class LeagueParser {
  final tableParser = MatchesTableParser();
  List<LeagueTeamRanking> parseLeagueTable(String htmlContent) {
    final rows = tableParser.getTableRows(htmlContent);

    if (rows.isEmpty) {
      developer.log("No rows in league overview table", level: 800);
      return [];
    }

    final dataRows = tableParser.getDataRows(rows);
    final List<LeagueTeamRanking> result = [];

    // TODO: add table indizes for league table in table parser?
    for (final row in dataRows) {
      result.add(
        LeagueTeamRanking(
          rank: Parser.getCellOrZero(row, 1),
          teamName: _getTeamname(row),
          teamUrl: _getTeamUrl(row),
          totalMatches: Parser.getCellOrZero(row, 3),
          wins: Parser.getCellOrZero(row, 4),
          draws: Parser.getCellOrZero(row, 5),
          losses: Parser.getCellOrZero(row, 6),
          leaguePointsWon: Parser.getCellTupleOrZero(row, 7)[0],
          gamesWon: Parser.getCellTupleOrZero(row, 8)[0],
          gamesLost: Parser.getCellTupleOrZero(row, 8)[1],
          setsWon: Parser.getCellTupleOrZero(row, 9)[0],
          setsLost: Parser.getCellTupleOrZero(row, 9)[1],
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

  static Future<String> parseLeagueName(String htmlContent) async {
    if (htmlContent.trim().isEmpty) {
      return "";
    }

    final document = html.parse(htmlContent);

    // Extrahiere den Text aus dem <h1>-Tag
    String? h1Text = document.querySelector('h1')?.text;

    if (h1Text != null) {
      // Teile den Text in Zeilen auf (an <br />-Tags)
      List<String> lines = h1Text
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .toList();

      if (lines.length >= 2) {
        String secondLine = lines[1].trim();

        String cleanedLine = secondLine
            .replaceAll(RegExp(r'&quot;|\"'), '')
            .replaceAll(RegExp(r'\([^)]*\)'), '')
            .trim();

        return cleanedLine;
      }
    }

    return "";
  }

  Future<String> parseMatchupsUrl(String baseUrl, String htmlContent) async {
    if (htmlContent.trim().isEmpty) {
      return "";
    }

    final document = html.parse(htmlContent);

    final h2 = document
        .getElementsByTagName('h2')
        .where((element) => element.text.trim() == 'Tabellen und Spielpläne')
        .firstOrNull;

    if (h2 == null) {
      developer.log('No h2 "Tabellen und Spielpläne found"', level: 900);
      return "";
    }

    final ul = h2.nextElementSibling;
    if (ul == null || ul.localName != 'ul') {
      developer.log(
        'No ul found after h2 "Tabellen und Spielpläne"',
        level: 900,
      );
      return "";
    }

    final li = ul
        .getElementsByTagName('li')
        .where(
          (li) =>
              li.text.contains('Spielplan') &&
              !li.text.contains('Tabelle und Spielplan'),
        )
        .firstOrNull;
    if (li == null) {
      developer.log(
        'No li with "Spielplan" found in ul after h2 "Tabellen und Spielpläne"',
        level: 900,
      );
      return "";
    }

    final a = li
        .getElementsByTagName('a')
        .where((a) => a.text.contains('gesamt'))
        .firstOrNull;
    if (a == null || !a.attributes.containsKey('href')) {
      developer.log(
        'No a with href with text "gesamt" found in li with "Spielplan"',
        level: 900,
      );
      return "";
    }

    final href = a.attributes['href']!;
    return Uri.parse(baseUrl).resolve(href).toString();
  }
}
