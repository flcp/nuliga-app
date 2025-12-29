import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/services/last-matches/last_matches_repository.dart';

class LastMatchesService {
  static Future<List<MatchResult>> getLastMatchesForTeam(
    String matchupsUrl,
    String teamName,
  ) async {
    var allMatches = await LastMatchesRepository().getLastMatches(matchupsUrl);
    return allMatches
        .where(
          (match) =>
              match.homeTeamName == teamName ||
              match.opponentTeamName == teamName,
        )
        .toList();
  }
}
