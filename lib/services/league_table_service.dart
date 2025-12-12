import 'dart:math';

import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/league_team_standing.dart';
import 'package:nuliga_app/services/league-table/league_table_repository.dart';

class LeagueTableService {
  static Future<List<LeagueTeamRanking>> getLeagueTeamRankings(
    String leagueUrl,
  ) {
    return LeagueTableRepository.getLeagueTeamRankings(leagueUrl);
  }

  static Future<List<LeagueTeamRanking>> getThreeClosestRankingsToTeam(
    String leagueUrl,
    FollowedClub team,
  ) async {
    final leagueTeamRankings =
        await LeagueTableRepository.getLeagueTeamRankings(leagueUrl);
    if (leagueTeamRankings.length < 3) {
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
    var lowIndex = teamIndex - 1;
    var highIndex = teamIndex + 1;

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
