import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/next-matches/next_matches_parser.dart';
import 'package:nuliga_app/services/shared/http.dart';

class NextMatchesRepository {
  static Future<List<FutureMatch>> getNextMatches(String matchupsUrl) async {
    final htmlContent = await fetchWebsiteCached(matchupsUrl);

    final baseUrl = getBaseUrl(matchupsUrl);

    final result = NextMatchesParser.getEntriesAsFutureMatches(
      htmlContent,
      baseUrl,
    );

    return result;
  }
}
