import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_standing.dart';

class LeagueTableOverviewListCard extends StatelessWidget {
  const LeagueTableOverviewListCard({
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
        children: threeClosestRankings.map((r) => Text(r.teamName)).toList(),
      ),
    );
  }
}
