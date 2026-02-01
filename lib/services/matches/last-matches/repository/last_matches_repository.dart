import 'package:nuliga_app/services/matches/last-matches/model/match_result.dart';
import 'package:nuliga_app/services/matches/last-matches/repository/last_matches_overview_parser.dart';
import 'package:nuliga_app/services/shared/http_client.dart';

class LastMatchesRepository {
  HttpClient httpClient = HttpClient();

  Future<List<MatchResult>> getLastMatches(String matchupsUrl) async {
    final htmlContent = await httpClient.get(matchupsUrl);

    final baseUrl = HttpClient.getBaseUrl(matchupsUrl);

    final result = LastMatchesOverviewParser().getMatchResultEntries(
      htmlContent,
      baseUrl,
    );

    return result;
  }
}
