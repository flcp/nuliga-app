import 'package:nuliga_app/model/league_team_ranking.dart';
import 'package:nuliga_app/services/league-table/league_table_repository.dart';
import 'package:nuliga_app/services/matches/next-matches/next_matches_repository.dart';

class SettingsService {
  final LeagueTableRepository leagueTableRepository = LeagueTableRepository();
  final NextMatchesRepository nextMatchesRepository = NextMatchesRepository();

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

  Future<String> getMatchupsUrlFromRankingUrl(String rankingUrl) {
    if (rankingUrl.isEmpty) {
      return Future.value("");
    }

    return leagueTableRepository.getMatchupsUrlFromRankingUrl(rankingUrl);
  }

  Future<bool> validateMatchupsUrl(String matchupsUrl) async {
    final rankings = await nextMatchesRepository.getNextMatches(matchupsUrl);
    return rankings.isNotEmpty;
  }

  bool? validateShortName(String shortName) {
    if (shortName.isEmpty) {
      return null;
    }

    return shortName.length <= 7;
  }

  bool validateTeam(String selectedTeamName) {
    return selectedTeamName.isNotEmpty;
  }
}
