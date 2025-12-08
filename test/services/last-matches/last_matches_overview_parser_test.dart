import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nuliga_app/services/last-matches/last_matches_overview_parser.dart';

void main() {
  group('LastMatchesOverviewParser with valid file input', () {
    test('parses sample file and identifies first entry correctly', () async {
      final file = File('test/assets/last-matches/test-page.html');
      final html = await file.readAsString();

      final result = LastMatchesOverviewParser().getMatchResultEntries(html);

      expect(result.length, 20);
      expect(result[0].homeTeam, "Fortuna Schwetzingen");
      expect(result[0].opponentTeam, "TSG Weinheim");
      expect(result[0].homeTeamMatchesWon, 7);
      expect(result[0].opponentTeamMatchesWon, 1);
    });

    test('parses sample file and parses date and time correctly', () async {
      final file = File('test/assets/last-matches/test-page.html');
      final html = await file.readAsString();

      final result = LastMatchesOverviewParser().getMatchResultEntries(html);

      expect(result[0].time, DateTime(2025, 10, 11, 14, 0));
    });
    test('parses sample file and back fills date from previous line', () async {
      final file = File('test/assets/last-matches/test-page.html');
      final html = await file.readAsString();

      final result = LastMatchesOverviewParser().getMatchResultEntries(html);

      expect(result[1].time, DateTime(2025, 10, 11, 14, 0));
    });

    test('with invalid file input returns empty list', () async {
      final file = File('test/assets/last-matches/otherFormat.json');
      final html = await file.readAsString();

      final result = LastMatchesOverviewParser().getMatchResultEntries(html);

      expect(result.length, 0);
    });
  });
}
