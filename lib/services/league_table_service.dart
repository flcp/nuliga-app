import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/league_team_standing.dart';
import 'package:nuliga_app/services/league-table/league_table_repository.dart';

class LeagueTableService {
  final leagueTableRepository = LeagueTableRepository();

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

    final indices = getInBoundsIndices(teamIndex, leagueTeamRankings.length);

    return Future.value(
      leagueTeamRankings.getRange(indices.lower, indices.higher + 1).toList(),
    );
  }

  // try to display one element higher and one element lower
  static ({int lower, int higher}) getInBoundsIndices(
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
