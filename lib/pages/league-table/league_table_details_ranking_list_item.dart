import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_standing.dart';

class LeagueTableDetailsRankingListItem extends StatelessWidget {
  const LeagueTableDetailsRankingListItem({
    super.key,
    required this.teamStanding,
    required this.team,
  });

  final LeagueTeamRanking teamStanding;
  final String team;

  @override
  Widget build(BuildContext context) {
    var twoLetterWidth = 18.0;

    return ListTile(
      title: DefaultTextStyle(
        style: TextStyle(
          fontSize: 14,
          color: teamStanding.teamName == team
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 24, child: Text(teamStanding.rank.toString())),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  teamStanding.teamName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(
              width: twoLetterWidth,
              child: Text(
                teamStanding.wins.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surfaceDim,
                ),
              ),
            ),
            SizedBox(
              width: twoLetterWidth,
              child: Text(
                teamStanding.draws.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surfaceDim,
                ),
              ),
            ),
            SizedBox(
              width: twoLetterWidth,
              child: Text(
                teamStanding.losses.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surfaceDim,
                ),
              ),
            ),
            SizedBox(
              width: twoLetterWidth,
              child: Text(
                teamStanding.totalMatches.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surfaceDim,
                ),
              ),
            ),
            SizedBox(
              width: 24,
              child: Text(
                teamStanding.leaguePointsWon.toString(),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
      selected: teamStanding.teamName == team,
    );
  }
}
