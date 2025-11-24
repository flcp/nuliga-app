import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nuliga_app/data-collector/league_parser.dart';

void main() {
  group('LeagueParser with valid file input', () {
    test(
      'parses sample file and identifies stats for first and last correctly',
      () async {
        final file = File('test/assets/test-page.html');
        final html = await file.readAsString();

        final result = LeagueParser.parse(html);

        expect(result.length, 8);

        final schwetzingen = result[0];
        expect(schwetzingen.teamName, 'Fortuna Schwetzingen');
        expect(schwetzingen.rank, 1);
        expect(schwetzingen.totalMatches, 5);
        expect(schwetzingen.wins, 4);
        expect(schwetzingen.draws, 1);
        expect(schwetzingen.losses, 0);
        expect(schwetzingen.leaguePointsWon, 9);
        expect(schwetzingen.gamesWon, 32);
        expect(schwetzingen.gamesLost, 8);
        expect(schwetzingen.setsWon, 66);
        expect(schwetzingen.setsLost, 23);

        final ettlingen = result[7];
        expect(ettlingen.teamName, 'SSV Ettlingen III');
        expect(ettlingen.rank, 8);
        expect(ettlingen.totalMatches, 5);
        expect(ettlingen.wins, 0);
        expect(ettlingen.draws, 1);
        expect(ettlingen.losses, 4);
        expect(ettlingen.leaguePointsWon, 1);
        expect(ettlingen.gamesWon, 13);
        expect(ettlingen.gamesLost, 27);
        expect(ettlingen.setsWon, 33);
        expect(ettlingen.setsLost, 60);
      },
    );
  });

  group('LeagueParser with invalid file input', () {
    test('defaults to 0 when encountering non-numbers', () async {
      final file = File('test/assets/broken-entries.html');
      final html = await file.readAsString();

      final result = LeagueParser.parse(html);

      expect(result.length, 4);

      final schwetzingen = result[0];
      expect(schwetzingen.teamName, 'Fortuna Schwetzingen');
      expect(schwetzingen.rank, 0);
      expect(schwetzingen.totalMatches, 0);
      expect(schwetzingen.wins, 0);
      expect(schwetzingen.draws, 0);
      expect(schwetzingen.losses, 0);
      expect(schwetzingen.leaguePointsWon, 0);
      expect(schwetzingen.gamesWon, 0);
      expect(schwetzingen.gamesLost, 0);
      expect(schwetzingen.setsWon, 0);
      expect(schwetzingen.setsLost, 0);
    });

    test('defaults to 0 when encountering empty ', () async {
      final file = File('test/assets/broken-entries.html');
      final html = await file.readAsString();

      final result = LeagueParser.parse(html);

      expect(result.length, 4);

      final emptyTeam = result[1];
      expect(emptyTeam.teamName, '');
      expect(emptyTeam.rank, 2);
      expect(emptyTeam.totalMatches, 0);
      expect(emptyTeam.wins, 0);
      expect(emptyTeam.draws, 0);
      expect(emptyTeam.losses, 0);
      expect(emptyTeam.leaguePointsWon, 0);
      expect(emptyTeam.gamesWon, 0);
      expect(emptyTeam.gamesLost, 0);
      expect(emptyTeam.setsWon, 0);
      expect(emptyTeam.setsLost, 0);
    });

    test(
      'defaults to 0 when encountering colon separated non-numbers',
      () async {
        final file = File('test/assets/broken-entries.html');
        final html = await file.readAsString();

        final result = LeagueParser.parse(html);

        expect(result.length, 4);

        final rastatt = result[2];
        expect(rastatt.teamName, 'BV Rastatt II');
        expect(rastatt.rank, 3);
        expect(rastatt.totalMatches, 0);
        expect(rastatt.wins, 0);
        expect(rastatt.draws, 0);
        expect(rastatt.losses, 0);
        expect(rastatt.leaguePointsWon, 0);
        expect(rastatt.gamesWon, 0);
        expect(rastatt.gamesLost, 0);
        expect(rastatt.setsWon, 0);
        expect(rastatt.setsLost, 0);
      },
    );

    test('defaults to 0 when encountering negative numbers', () async {
      final file = File('test/assets/broken-entries.html');
      final html = await file.readAsString();

      final result = LeagueParser.parse(html);

      expect(result.length, 4);

      final karlsruhe = result[3];
      expect(karlsruhe.teamName, 'SSC Karlsruhe');
      expect(karlsruhe.rank, 0);
      expect(karlsruhe.totalMatches, 0);
      expect(karlsruhe.wins, 0);
      expect(karlsruhe.draws, 0);
      expect(karlsruhe.losses, 0);
      expect(karlsruhe.leaguePointsWon, 0);
      expect(karlsruhe.gamesWon, 0);
      expect(karlsruhe.gamesLost, 0);
      expect(karlsruhe.setsWon, 0);
      expect(karlsruhe.setsLost, 0);
    });
  });
}
