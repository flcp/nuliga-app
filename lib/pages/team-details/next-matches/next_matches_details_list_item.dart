import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/date.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:url_launcher/url_launcher.dart';

class NextMatchesDetailsListItem extends StatelessWidget {
  final FutureMatch match;
  final String hometeam;
  final bool highlighted;
  final String matchOverviewUrl;
  final bool displayOnlyOpponentName;

  static const double spacingSubtitleBlocks = 16.0;
  static const double spacingSubtitleIcons = 8.0;

  const NextMatchesDetailsListItem({
    super.key,
    required this.match,
    required this.hometeam,
    required this.highlighted,
    required this.matchOverviewUrl,
    this.displayOnlyOpponentName = true,
  });

  @override
  Widget build(BuildContext context) {
    final subtitleIconColor = Theme.of(
      context,
    ).colorScheme.onSurface.withAlpha(150);

    return ListTile(
      subtitle: Row(
        spacing: 16,
        children: [
          Row(
            spacing: 4,
            children: [
              Icon(Icons.calendar_today, size: 18.0, color: subtitleIconColor),
              Text(getDateString(match.time)),
            ],
          ),
          Row(
            spacing: 4,
            children: [
              Icon(Icons.access_time, size: 18.0, color: subtitleIconColor),
              Text(
                "${match.time.hour}:${match.time.minute.toString().padLeft(2, "0")}",
              ),
            ],
          ),
          Expanded(
            child: Row(
              spacing: 4,
              children: [
                Icon(Icons.location_on, size: 18, color: subtitleIconColor),
                Expanded(
                  child: NextMatchesDetailsListLocationLink(
                    match: match,
                    hometeam: hometeam,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      title: Text(
        match.homeTeam == hometeam ? match.opponentTeam : match.homeTeam,
      ),
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
