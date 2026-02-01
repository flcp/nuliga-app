import 'package:nuliga_app/services/match-result/model/match_result_detail.dart';
import 'package:nuliga_app/services/match-result/repository/match_result_parser.dart';
import 'package:nuliga_app/services/shared/http_client.dart';

class MatchResultRepository {
  final httpClient = HttpClient();

  final matchResultParser = MatchResultParser();

  Future<MatchResultDetail> getMatchResult(String resultDetailUrl) async {
    final htmlContent = await httpClient.get(resultDetailUrl);

    return matchResultParser.getGamesAndResults(htmlContent);
  }
}
