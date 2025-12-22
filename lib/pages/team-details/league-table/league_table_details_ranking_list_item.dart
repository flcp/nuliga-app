import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_standing.dart';
import 'package:nuliga_app/pages/team-details/team_details_league_team_inspectordart.dart';

class LeagueTableDetailsRankingListItem extends StatefulWidget {
  const LeagueTableDetailsRankingListItem({
    super.key,
    required this.teamStanding,
    required this.team,
    required this.matchOverviewUrl,
  });

  final LeagueTeamRanking teamStanding;
  final String team;
  final String matchOverviewUrl;

  @override
  State<LeagueTableDetailsRankingListItem> createState() =>
      _LeagueTableDetailsRankingListItemState();
}

class _LeagueTableDetailsRankingListItemState
    extends State<LeagueTableDetailsRankingListItem> {
  @override
  Widget build(BuildContext context) {
    final twoLetterWidth = 18.0;
    final dimTextColor = Theme.of(context).disabledColor;

    final isHighlighted = widget.teamStanding.teamName == widget.team;

    return ListTile(
      onTap: () => goToTeamInspector(),
      title: DefaultTextStyle.merge(
        style: TextStyle(
          color: isHighlighted
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).textTheme.bodyMedium!.color,
          fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 24,
              child: Text(
                widget.teamStanding.rank.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  widget.teamStanding.teamName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(
              width: twoLetterWidth,
              child: Text(
                widget.teamStanding.wins.toString(),
                style: TextStyle(color: dimTextColor),
              ),
            ),
            SizedBox(
              width: twoLetterWidth,
              child: Text(
                widget.teamStanding.draws.toString(),
                style: TextStyle(color: dimTextColor),
              ),
            ),
            SizedBox(
              width: twoLetterWidth,
              child: Text(
                widget.teamStanding.losses.toString(),
                style: TextStyle(color: dimTextColor),
              ),
            ),

            SizedBox(
              width: 24,
              child: Text(
                widget.teamStanding.leaguePointsWon.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: twoLetterWidth,
              child: Text(
                widget.teamStanding.totalMatches.toString(),
                style: TextStyle(color: dimTextColor),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
      trailing: Icon(Icons.chevron_right),
    );
  }

  void goToTeamInspector() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailsLeagueTeamInspector(
          teamName: widget.teamStanding.teamName,
          matchOverviewUrl: widget.matchOverviewUrl,
        ),
      ),
    );
  }
}
