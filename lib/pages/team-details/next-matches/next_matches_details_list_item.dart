import 'package:flutter/material.dart';
import 'package:nuliga_app/services/matches/next-matches/model/future_match.dart';
import 'package:nuliga_app/pages/next-match/next_match_page.dart';
import 'package:nuliga_app/services/shared/date.dart';

class NextMatchesDetailsListItem extends StatefulWidget {
  final FutureMatch match;
  final String team;
  final String matchOverviewUrl;
  final bool displayOnlyOpponentName;

  const NextMatchesDetailsListItem({
    super.key,
    required this.match,
    required this.team,
    required this.matchOverviewUrl,
    this.displayOnlyOpponentName = true,
  });

  @override
  State<NextMatchesDetailsListItem> createState() =>
      _NextMatchesDetailsListItemState();
}

class _NextMatchesDetailsListItemState
    extends State<NextMatchesDetailsListItem> {
  static const double spacingSubtitleBlocks = 16.0;

  @override
  Widget build(BuildContext context) {
    final subtitleIconColor = Theme.of(
      context,
    ).colorScheme.onSurface.withAlpha(120);

    return ListTile(
      onTap: () => goToUpComingMatch(widget.match, widget.team),
      leading: Icon(
        widget.match.isHomeTeam(widget.team)
            ? Icons.home
            : Icons.directions_car,
        color: subtitleIconColor,
      ),
      trailing: Icon(Icons.chevron_right),
      subtitle: Row(
        spacing: spacingSubtitleBlocks,
        children: [Text(Date.getDateString(widget.match.time))],
      ),
      title: Text(
        widget.match.isHomeTeam(widget.team)
            ? widget.match.opponentTeam
            : widget.match.homeTeam,
      ),
    );
  }

  void goToUpComingMatch(FutureMatch match, String teamName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextMatchPage(match: match, teamName: teamName),
      ),
    );
  }
}
