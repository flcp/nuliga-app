import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/next-matches/next_matches_parser.dart';
import 'package:nuliga_app/services/shared/http.dart';

class NextMatchesRepository {
  HttpClient httpClient = HttpClient();

  Future<List<FutureMatch>> getNextMatches(String matchupsUrl) async {
    final htmlContent = await httpClient.get(matchupsUrl);

    final baseUrl = HttpClient.getBaseUrl(matchupsUrl);

    final result = NextMatchesParser.getEntriesAsFutureMatches(
      htmlContent,
      baseUrl,
    );

    return result;
  }
}
