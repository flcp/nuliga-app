import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nuliga_app/services/last-matches/last_matches_overview_parser.dart';

void main() {
  group('LastMatchesOverviewParser with valid file input', () {
    test('parses sample file and identifies first entry correctly', () async {
      final file = File('test/assets/last-matches/test-page.html');
      final html = await file.readAsString();

      final result = LastMatchesOverviewParser().getEntriesAsMatchResults(html);

      expect(result.length, 20);
      expect(result[0].homeTeam, "Fortuna Schwetzingen");
      expect(result[0].opponentTeam, "TSG Weinheim");
      expect(result[0].homeTeamMatchesWon, 7);
      expect(result[0].opponentTeamMatchesWon, 1);
    });
  });
}
