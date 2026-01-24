import 'package:nuliga_app/model/league_team_ranking.dart';
import 'package:nuliga_app/services/shared/http_client.dart';
import 'package:nuliga_app/services/league-table/league_parser.dart';

class LeagueTableRepository {
  final HttpClient httpClient = HttpClient();
  final leagueParser = LeagueParser();

  Future<List<LeagueTeamRanking>> getLeagueTeamRankings(
    String leagueUrl,
  ) async {
    final htmlContent = await httpClient.get(leagueUrl);

    return leagueParser.parseLeagueTable(htmlContent);
  }

  Future<String> getLeagueName(String leagueUrl) async {
    final htmlContent = await httpClient.get(leagueUrl);

    return LeagueParser.parseLeagueName(htmlContent);
  }

  Future<String> getMatchupsUrlFromRankingUrl(String rankingUrl) async {
    final htmlContent = await httpClient.get(rankingUrl);
    final baseUrl = HttpClient.getBaseUrl(rankingUrl);

    return leagueParser.parseMatchupsUrl(baseUrl, htmlContent);
  }
}
