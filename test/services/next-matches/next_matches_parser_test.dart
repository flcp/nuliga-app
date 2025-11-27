import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nuliga_app/services/next-matches/next_matches_parser.dart';

void main() {
  group('NextMatchesParser with valid file input', () {
    test('parses sample file and identifies first entry correctly', () async {
      final file = File('test/assets/next-matches/test-page.html');
      final html = await file.readAsString();

      final result = NextMatchesParser.getEntriesAsFutureMatches(html);

      expect(result.length, 56);
      expect(result[0].homeTeam, "Fortuna Schwetzingen");
      expect(result[0].opponentTeam, "TSG Weinheim");
    });
  });
  test('NextMatchesParser with invalid file input', () async {
    final file = File('test/assets/next-matches/otherFormat.json');
    final html = await file.readAsString();

    final result = NextMatchesParser.getEntriesAsFutureMatches(html);

    expect(result.length, 56);
  });
}
