import 'package:nuliga_app/model/league_team_standing.dart';
import 'package:nuliga_app/services/league-table/league_table_repository.dart';

class LeagueTableService {
  static Future<List<LeagueTeamRanking>> getLeagueTeamRankings(
    String leagueUrl,
  ) {
    return LeagueTableRepository.getLeagueTeamRankings(leagueUrl);
  }
}
