import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/next-matches/next_matches_repository.dart';

class NextMatchesService {
  static Future<List<FutureMatch>> getNextMatchesForTeam(
    String matchupsUrl,
    String teamName,
  ) async {
    var allMatches = await NextMatchesRepository.getNextMatches(matchupsUrl);
    var matchesForTeam = allMatches
        .where(
          (match) =>
              match.homeTeam == teamName || match.opponentTeam == teamName,
        )
        .toList();
    return getMatchesTodayOrLater(matchesForTeam);
  }

  static List<FutureMatch> getMatchesTodayOrLater(
    List<FutureMatch> allMatches,
  ) {
    final now = DateTime.now();
    final todayAtMidnight = DateTime(now.year, now.month, now.day, 1);
    return allMatches
        .where((match) => match.time.isAfter(todayAtMidnight))
        .toList();
  }
}
