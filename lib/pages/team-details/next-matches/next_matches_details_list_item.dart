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
              Text(getDateString(widget.match.time)),
            ],
          ),
          Row(
            spacing: spacingSubtitleIcons,
            children: [
              Icon(Icons.access_time, size: 18.0, color: subtitleIconColor),
              Text(
                "${widget.match.time.hour}:${widget.match.time.minute.toString().padLeft(2, "0")}",
              ),
            ],
          ),
          Expanded(
            child: Row(
              spacing: spacingSubtitleIcons,
              children: [
                Icon(Icons.location_on, size: 18, color: subtitleIconColor),
                Expanded(
                  child: NextMatchesDetailsListLocationLink(
                    match: widget.match,
                    hometeam: widget.hometeam,
                  ),
                ),
              ],
            ),
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

class NextMatchesDetailsListLocationLink extends StatelessWidget {
  NextMatchesDetailsListLocationLink({
    super.key,
    required this.match,
    required this.hometeam,
  });

  final FutureMatch match;
  final String hometeam;

  final nextMatchesService = NextMatchesService();

  @override
  Widget build(BuildContext context) {
    if (match.homeTeam == hometeam) {
      return Text("Home");
    }

    if (match.locationUrl.isEmpty) {
      return Text("TBD");
    }

    return FutureBuilder(
      future: nextMatchesService.getLocation(match),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        final location = getDataOrDefault(snapshot, "Unknown");
        Uri locationGoogleUri;
        try {
          locationGoogleUri = Uri.parse(
            NextMatchesService.getGoogleMapsLink(location),
          );
        } on FormatException {
          return Text("location");
        }

        return InkWell(
          onTap: () async {
            await launchUrl(locationGoogleUri);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceDim.withAlpha(120),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(
                horizontal: 12,
                vertical: 1,
              ),
              child: Text(
                location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
}
