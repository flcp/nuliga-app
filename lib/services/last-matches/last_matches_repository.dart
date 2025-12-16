import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/services/last-matches/last_matches_overview_parser.dart';
import 'package:nuliga_app/services/shared/http.dart';

class LastMatchesRepository {
  Future<List<MatchResult>> getLastMatches(String matchupsUrl) async {
    final htmlContent = await fetchWebsiteCached(matchupsUrl);

    final baseUrl = getBaseUrl(matchupsUrl);

    final result = LastMatchesOverviewParser().getMatchResultEntries(
      htmlContent,
      baseUrl,
    );

    return result;
  }
}
