import 'package:nuliga_app/model/league_team_ranking.dart';
import 'package:nuliga_app/services/league-table/league_table_repository.dart';

class SettingsService {
  final LeagueTableRepository leagueTableRepository = LeagueTableRepository();
  Future<bool> validateRankingTableUrl(String url) async {
    final rankings = await leagueTableRepository.getLeagueTeamRankings(url);
    return rankings.isNotEmpty;
  }

  Future<List<LeagueTeamRanking>> fetchTeamRankings(String url) async {
    if (url.isEmpty) {
      return [];
    }

    var teamRankings = await leagueTableRepository.getLeagueTeamRankings(url);
    teamRankings.sort((a, b) => a.teamName.compareTo(b.teamName));
    return teamRankings;
  }
}
