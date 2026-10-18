import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
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
    final date = context.getDate();
    final localization = AppLocalizations.of(context)!;
    final iconColor = Theme.of(context).colorScheme.onSurface.withAlpha(120);
    final subtitleTextStyle = Theme.of(context).textTheme.bodySmall;
    final titleTextStyle = Theme.of(context).textTheme.titleMedium;

    return InkWell(
      onTap: () => goToUpComingMatch(widget.match, widget.team),
      child: Padding(
        padding: const EdgeInsets.all(Constants.smallCardPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Text(
                      date.getLongDateStringWithoutYear(widget.match.time),
                      style: subtitleTextStyle,
                    ),
                    Text("·"),
                    Text(
                      "${widget.match.time.hour}:${widget.match.time.minute.toString().padLeft(2, "0")}",
                      style: subtitleTextStyle,
                    ),
                    Text("·"),
                    Text(
                      widget.match.isHomeTeam(widget.team)
                          ? localization.homeGame_short
                          : localization.awayGame_short,
                      style: subtitleTextStyle,
                    ),
                  ],
                ),
                Text(
                  widget.match.getOpponent(widget.team),
                  style: titleTextStyle,
                ),
              ],
            ),
            Icon(
              widget.match.isHomeTeam(widget.team)
                  ? Icons.home
                  : Icons.directions_car,
              color: iconColor,
            ),
          ],
        ),
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
