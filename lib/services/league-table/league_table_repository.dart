import 'package:nuliga_app/model/league_team_standing.dart';
import 'package:nuliga_app/services/shared/http_client.dart';
import 'package:nuliga_app/services/league-table/league_parser.dart';

class LeagueTableRepository {
  HttpClient httpClient = HttpClient();

  Future<List<LeagueTeamRanking>> getLeagueTeamRankings(
    String leagueUrl,
  ) async {
    final htmlContent = await httpClient.get(leagueUrl);

    return LeagueParser.parseLeagueTable(htmlContent);
  }
}
