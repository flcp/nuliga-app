import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_ranking.dart';
import 'package:nuliga_app/pages/team-details/team_details_league_team_inspector.dart';

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
    final isHighlighted = widget.teamStanding.teamName == widget.team;

    return ListTile(
      dense: true,
      onTap: () => goToTeamInspector(),
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
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
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.teamStanding.teamName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            TwoLetterTextBox(text: widget.teamStanding.wins.toString()),
            TwoLetterTextBox(text: widget.teamStanding.draws.toString()),
            TwoLetterTextBox(text: widget.teamStanding.losses.toString()),
            SizedBox(
              width: 24,
              child: Text(
                widget.teamStanding.leaguePointsWon.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            TwoLetterTextBox(text: widget.teamStanding.totalMatches.toString()),
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

class TwoLetterTextBox extends StatelessWidget {
  const TwoLetterTextBox({super.key, required this.text});

  static const double twoLetterWidth = 18.0;
  final String text;

  @override
  Widget build(BuildContext context) {
    final Color dimTextColor = Theme.of(context).disabledColor;
    return SizedBox(
      width: twoLetterWidth,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: dimTextColor),
      ),
    );
  }
}
