import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_standing.dart';

class TeamOvervieewLeagueTableExcerptItem extends StatelessWidget {
  final LeagueTeamRanking teamRanking;
  final bool highlighted;

  const TeamOvervieewLeagueTableExcerptItem({
    super.key,
    required this.teamRanking,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: highlighted,
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
