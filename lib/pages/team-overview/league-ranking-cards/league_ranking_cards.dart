import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/league_team_ranking.dart';
import 'package:nuliga_app/model/short_league_team_ranking.dart';
import 'package:nuliga_app/services/league_table_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LeagueRankingCards extends StatelessWidget {
  LeagueRankingCards({
    super.key,
    required this.teams
  });

  final LeagueTableService leagueTableService = LeagueTableService();
  final List<FollowedClub> teams;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: teams.map((team) => FutureBuilder(
      future: leagueTableService.getShortRankingForTeam(team.rankingTableUrl, team.name),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 170,
            child: AspectRatio(
              aspectRatio: 1,
              child: Card(elevation: 0),
            ),
          );
        }

        final shortRank = getDataOrDefault(asyncSnapshot, ShortLeagueTeamRanking.empty);

        return SizedBox(
          height: 170,
          child: AspectRatio(
            aspectRatio: 1,
            child: Card(child: Column(
              children: [
                Text(shortRank.teamName),
                Row(
                  children: [
                    Text(shortRank.rank.toString()),
                    Text("/${shortRank.totalTeams}"),
                  ],
                )
              ],
            )),
          ),
        );
      }
    )).toList(),);
  }
}
