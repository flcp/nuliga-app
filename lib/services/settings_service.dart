import 'package:nuliga_app/services/league-table/league_table_repository.dart';

class SettingsService {
  final LeagueTableRepository leagueTableRepository = LeagueTableRepository();
  Future<bool> validateRankingTableUrl(String url) async {
    final rankings = await leagueTableRepository.getLeagueTeamRankings(url);
    return rankings.isNotEmpty;
  }
}
