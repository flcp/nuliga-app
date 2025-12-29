import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/next-match/next_match_page.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/date.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:url_launcher/url_launcher.dart';

class NextMatchesDetailsListItem extends StatefulWidget {
  final FutureMatch match;
  final String hometeam;
  final String matchOverviewUrl;
  final bool displayOnlyOpponentName;

  const NextMatchesDetailsListItem({
    super.key,
    required this.match,
    required this.hometeam,
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
  static const double spacingSubtitleIcons = 4.0;

  @override
  Widget build(BuildContext context) {
    final subtitleIconColor = Theme.of(
      context,
    ).colorScheme.onSurface.withAlpha(150);

    return ListTile(
      onTap: () => goToUpComingMatch(widget.match),
      trailing: Icon(Icons.chevron_right),
      subtitle: Row(
        spacing: spacingSubtitleBlocks,
        children: [
          Row(
            spacing: spacingSubtitleIcons,
            children: [
              Icon(Icons.calendar_today, size: 18.0, color: subtitleIconColor),
              Text(Date.getDateString(widget.match.time)),
            ],
          ),
        ],
      ),
      title: Text(
        widget.match.homeTeam == widget.hometeam
            ? widget.match.opponentTeam
            : widget.match.homeTeam,
      ),
    );
  }

  void goToUpComingMatch(FutureMatch match) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NextMatchPage(match: match)),
    );
  }
}
