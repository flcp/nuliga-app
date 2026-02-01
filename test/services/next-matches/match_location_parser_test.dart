import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nuliga_app/services/matches/next-matches/repository/match_location_parser.dart';

void main() {
  group('NextMatchesParser with valid file input', () {
    test('parses rosenau file well', () async {
      final file = File('test/assets/next-matches/location-rosenau.html');
      final html = await file.readAsString();

      final result = MatchLocationParser.getLocationAdress(html);

      expect(result, "Bergstr. 40 74072 Heilbronn");
    });
    test('parses rastatt file well', () async {
      final file = File('test/assets/next-matches/location-jahnhalle.html');
      final html = await file.readAsString();

      final result = MatchLocationParser.getLocationAdress(html);
      expect(result, "Gerhart-Hauptmann-Str. 16 69221 Dossenheim");
    });
    test('parses jahnhalle well', () async {
      final file = File('test/assets/next-matches/location-rastatt.html');
      final html = await file.readAsString();

      final result = MatchLocationParser.getLocationAdress(html);
      expect(result, "Lyzeumstr. 11 (Zufahrt über Engelstr.) 76437 Rastatt");
    });
  });
}
