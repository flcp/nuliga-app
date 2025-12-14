import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_standing.dart';

class ShortLeagueTableItem extends StatelessWidget {
  final LeagueTeamRanking teamRanking;
  final bool highlighted;

  const ShortLeagueTableItem({
    super.key,
    required this.teamRanking,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(
        color: highlighted
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).textTheme.bodyMedium!.color,
        fontWeight: highlighted ? FontWeight.bold : FontWeight.normal,
      ),
      child: Row(
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
