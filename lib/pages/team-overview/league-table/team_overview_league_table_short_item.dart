import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_standing.dart';

class TeamOverviewLeagueTableShortItem extends StatelessWidget {
  const TeamOverviewLeagueTableShortItem({
    super.key,
    required this.threeClosestRankings,
  });

  final List<LeagueTeamRanking> threeClosestRankings;

  @override
  Widget build(BuildContext context) {
    return Card(
      // TODO: ggf. auslagern
      // margin: EdgeInsets.fromLTRB(16, 4, 16, 24),
      child: Column(
        children: threeClosestRankings
            .map((r) => LeagueTableOverviewListCardItem(teamRanking: r))
            .toList(),
      ),
    );
  }
}

class LeagueTableOverviewListCardItem extends StatelessWidget {
  final LeagueTeamRanking teamRanking;
  const LeagueTableOverviewListCardItem({required this.teamRanking, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 24, child: Text(teamRanking.rank.toString())),

          Expanded(child: Text(teamRanking.teamName)),
          SizedBox(
            width: 24,
            child: Text(
              teamRanking.leaguePointsWon.toString(),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
