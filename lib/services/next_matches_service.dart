import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/next-matches/match_location_repository.dart';
import 'package:nuliga_app/services/next-matches/next_matches_repository.dart';
import 'package:nuliga_app/services/shared/http.dart';

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

  static Future<String> getLocationMapsLink(
    FutureMatch match,
    String matchOverviewUrl,
  ) async {
    if (match.locationUrl.isEmpty) return Future.value("");

    final url = getBaseUrl(matchOverviewUrl) + match.locationUrl;
    final locationAdress = await MatchLocationRepository.getMatchLocation(url);

    return createGoogleMapsLink(locationAdress);
  }

  static String createGoogleMapsLink(String address) {
    final encodedAdress = Uri.encodeComponent(address);

    return "https://www.google.com/maps/search/?api=1&query=$encodedAdress";
  }
}
