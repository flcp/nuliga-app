import 'package:nuliga_app/services/followed-teams/followed_club.dart';
import 'package:nuliga_app/services/league-table/model/league_team_ranking.dart';
import 'package:nuliga_app/services/league-table/model/short_league_team_ranking.dart';
import 'package:nuliga_app/services/league-table/repository/league_table_repository.dart';

class LeagueTableService {
  final leagueTableRepository = LeagueTableRepository();

  Future<ShortLeagueTeamRanking> getShortRankingForTeam(
    String leagueUrl,
    String teamName,
  ) async {
    final teamRankings = await leagueTableRepository.getLeagueTeamRankings(
      leagueUrl,
    );

    final leagueName = await leagueTableRepository.getLeagueName(leagueUrl);
    final totalTeams = teamRankings.length;

    if (totalTeams == 0) {
      return ShortLeagueTeamRanking.empty;
    }

    LeagueTeamRanking teamRanking;
    try {
      teamRanking = teamRankings.firstWhere(
        (teamRanking) => teamRanking.teamName == teamName,
      );
    } catch (e) {
      return ShortLeagueTeamRanking.empty;
    }

    return Future.value(
      ShortLeagueTeamRanking(
        rank: teamRanking.rank,
        wins: teamRanking.wins,
        playedMatches: teamRanking.totalMatches,
        totalTeams: totalTeams,
        teamName: teamRanking.teamName,
        teamUrl: teamRanking.teamUrl,
        leagueName: leagueName,
      ),
    );
  }

  Future<List<LeagueTeamRanking>> getLeagueTeamRankings(String leagueUrl) {
    return leagueTableRepository.getLeagueTeamRankings(leagueUrl);
  }

  Future<List<LeagueTeamRanking>> getClosestRankingsToTeam(
    String leagueUrl,
    FollowedClub team,
  ) async {
    final leagueTeamRankings = await leagueTableRepository
        .getLeagueTeamRankings(leagueUrl);
    if (leagueTeamRankings.length < 5) {
      return leagueTeamRankings;
    }

    final teamIndex = leagueTeamRankings.indexWhere(
      (r) => r.teamName == team.name,
    );

    final indices = _getInBoundsIndices(teamIndex, leagueTeamRankings.length);

    return Future.value(
      leagueTeamRankings.getRange(indices.lower, indices.higher + 1).toList(),
    );
  }

  // try to get all teams with ranking +-2
  static ({int lower, int higher}) _getInBoundsIndices(
    int teamIndex,
    int maxIndex,
  ) {
    var lowIndex = teamIndex - 2;
    var highIndex = teamIndex + 2;

    while (lowIndex < 0) {
      lowIndex++;
      highIndex++;
    }
    while (highIndex >= maxIndex) {
      lowIndex--;
      highIndex--;
    }

    return (lower: lowIndex, higher: highIndex);
  }
}
