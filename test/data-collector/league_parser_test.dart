import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nuliga_app/data-collector/league_parser.dart';

void main() {
  group('LeagueParser with file input', () {
    test('parses sample file mid season correctly', () async {
      final file = File('test/assets/test-page.html');
      final html = await file.readAsString();

      final result = LeagueParser.parse(html);

      expect(result.length, 8);

      final first = result[0];
      expect(first.teamName, 'Fortuna Schwetzingen');
      expect(first.rank, 1);
      expect(first.totalMatches, 5);
      expect(first.wins, 4);
      expect(first.draws, 1);
      expect(first.losses, 0);
      expect(first.leaguePointsWon, 9);
      expect(first.gamesWon, 32);
      expect(first.gamesLost, 8);
      expect(first.setsWon, 66);
      expect(first.setsLost, 23);

    });
  });
}