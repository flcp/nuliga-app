import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/next-matches/match_location_repository.dart';
import 'package:nuliga_app/services/next-matches/next_matches_repository.dart';

class NextMatchesService {
  static Future<({List<FutureMatch> next, List<FutureMatch> later})>
  getNextMatchesWithNextGamedaySeparate(String matchesUrl, String name) async {
    var allMatches = await NextMatchesRepository.getNextMatches(matchesUrl);
    var matchesForTeam = allMatches
        .where((match) => match.homeTeam == name || match.opponentTeam == name)
        .toList();
    var matchesForTeamTodayOrLater = _getMatchesTodayOrLater(matchesForTeam);
    return (
      next: matchesForTeamTodayOrLater
          .where((match) => isOnNextMatchDay(match, matchesForTeamTodayOrLater))
          .toList(),
      later: matchesForTeamTodayOrLater
          .where(
            (match) => !isOnNextMatchDay(match, matchesForTeamTodayOrLater),
          )
          .toList(),
    );
  }

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

  static Future<String> getLocationMapsLink(FutureMatch match) async {
    if (match.locationUrl.isEmpty) return Future.value("");

    final locationAddress = await MatchLocationRepository.getMatchLocation(
      match.locationUrl,
    );

    return _createGoogleMapsLink(locationAddress);
  }

  static String _createGoogleMapsLink(String address) {
    final encodedAddress = Uri.encodeComponent(address);

    return "https://www.google.com/maps/search/?api=1&query=$encodedAddress";
  }

  static bool isOnNextMatchDay(
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
