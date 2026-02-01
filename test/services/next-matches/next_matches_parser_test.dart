import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nuliga_app/services/matches/next-matches/repository/next_matches_parser.dart';

void main() {
  group('NextMatchesParser with valid file input', () {
    test('parses sample file and identifies first entry correctly', () async {
      final file = File('test/assets/next-matches/test-page.html');
      final html = await file.readAsString();

      final result = NextMatchesParser().getEntriesAsFutureMatches(
        html,
        "http://example.com/",
      );

      expect(result.length, 56);
      expect(result[0].homeTeam, "Fortuna Schwetzingen");
      expect(result[0].opponentTeam, "TSG Weinheim");
    });
    test('parses sample file and parses date and time correctly', () async {
      final file = File('test/assets/next-matches/test-page.html');
      final html = await file.readAsString();

      final result = NextMatchesParser().getEntriesAsFutureMatches(
        html,
        "http://example.com/",
      );

      expect(result[0].time, DateTime(2025, 10, 11, 14, 0));
    });
    test('parses sample file and back fills date from previous line', () async {
      final file = File('test/assets/next-matches/test-page.html');
      final html = await file.readAsString();

      final result = NextMatchesParser().getEntriesAsFutureMatches(
        html,
        "http://example.com/",
      );

      expect(result[1].time, DateTime(2025, 10, 11, 14, 0));
    });
  });

  test(
    'NextMatchesParser with invalid file input returns empty list',
    () async {
      final file = File('test/assets/next-matches/otherFormat.json');
      final html = await file.readAsString();

      final result = NextMatchesParser().getEntriesAsFutureMatches(
        html,
        "http://example.com/",
      );

      expect(result.length, 0);
    },
  );

  // TODO: write test for link parsing
}
