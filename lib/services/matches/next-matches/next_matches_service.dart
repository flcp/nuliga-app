import 'package:nuliga_app/services/matches/next-matches/model/future_match.dart';
import 'package:nuliga_app/services/matches/next-matches/repository/match_location_repository.dart';
import 'package:nuliga_app/services/matches/next-matches/repository/next_matches_repository.dart';

class NextMatchesService {
  final nextMatchesRepository = NextMatchesRepository();
  final matchLocationRepository = MatchLocationRepository();

  Future<({List<FutureMatch> next, List<FutureMatch> later})>
  getNextMatchesWithNextGamedaySeparate(String matchesUrl, String name) async {
    var allMatches = await nextMatchesRepository.getNextMatches(matchesUrl);
    var matchesForTeam = allMatches
        .where((match) => match.homeTeam == name || match.opponentTeam == name)
        .toList();
    var matchesForTeamTodayOrLater = _getMatchesTodayOrLater(matchesForTeam);
    return (
      next: matchesForTeamTodayOrLater
          .where(
            (match) => _isOnNextMatchDay(match, matchesForTeamTodayOrLater),
          )
          .toList(),
      later: matchesForTeamTodayOrLater
          .where(
            (match) => !_isOnNextMatchDay(match, matchesForTeamTodayOrLater),
          )
          .toList(),
    );
  }

  Future<List<FutureMatch>> getNextMatchesForTeam(
    String matchupsUrl,
    String teamName,
  ) async {
    var allMatches = await nextMatchesRepository.getNextMatches(matchupsUrl);
    var matchesForTeam = allMatches
        .where(
          (match) =>
              match.homeTeam == teamName || match.opponentTeam == teamName,
        )
        .toList();
    return _getMatchesTodayOrLater(matchesForTeam);
  }

  static List<FutureMatch> _getMatchesTodayOrLater(
    List<FutureMatch> allMatches,
  ) {
    final now = DateTime.now();
    final todayAtMidnight = DateTime(now.year, now.month, now.day, 1);
    return allMatches
        .where((match) => match.time.isAfter(todayAtMidnight))
        .toList();
  }

  static bool _isOnNextMatchDay(
    FutureMatch match,
    List<FutureMatch> nextMatches,
  ) {
    final nextMatchTime = nextMatches
        .map((m) => m.time)
        .toList()
        .reduce((min, e) => e.isBefore(min) ? e : min);

    return match.time.day == nextMatchTime.day &&
        match.time.month == nextMatchTime.month &&
        match.time.year == nextMatchTime.year;
  }
}
