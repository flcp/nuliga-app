import 'package:nuliga_app/model/league_team_ranking.dart';
import 'package:nuliga_app/model/validation_result.dart';
import 'package:nuliga_app/services/league-table/league_table_repository.dart';
import 'package:nuliga_app/services/matches/next-matches/next_matches_repository.dart';

class SettingsService {
  final LeagueTableRepository leagueTableRepository = LeagueTableRepository();
  final NextMatchesRepository nextMatchesRepository = NextMatchesRepository();

  Future<ValidationResult> validateRankingTableUrl(String url) async {
    if (url.isEmpty) {
      return ValidationResult.invalid;
    }

    final rankings = await leagueTableRepository.getLeagueTeamRankings(url);

    return rankings.isNotEmpty
        ? ValidationResult.valid
        : ValidationResult.invalid;
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

  Future<ValidationResult> validateMatchupsUrl(String matchupsUrl) async {
    if (matchupsUrl.isEmpty) {
      return ValidationResult.invalid;
    }

    final rankings = await nextMatchesRepository.getNextMatches(matchupsUrl);
    return rankings.isNotEmpty
        ? ValidationResult.valid
        : ValidationResult.invalid;
  }

  ValidationResult validateShortName(String shortName) {
    if (shortName.isEmpty) {
      return ValidationResult.invalid;
    }

    return shortName.length <= 7
        ? ValidationResult.valid
        : ValidationResult.invalid;
  }

  ValidationResult validateTeam(String selectedTeamName) {
    return selectedTeamName.isEmpty
        ? ValidationResult.invalid
        : ValidationResult.valid;
  }
}
