import 'package:nuliga_app/model/league_team_standing.dart';
import 'package:nuliga_app/services/shared/http.dart';
import 'package:nuliga_app/services/league-table/league_parser.dart';

class LeagueTableRepository {
  static Future<List<LeagueTeamRanking>> getLeagueTeamRankings(
    String leagueUrl,
  ) async {
    final htmlContent = await fetchWebsiteCached(leagueUrl);
    final result = LeagueParser.parse(htmlContent);

    return result;
  }
}
