import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/services/shared/date.dart';

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
    return ListTile(
      subtitle: Row(
        spacing: 12,
        children: [
          Row(
            spacing: 4,
            children: [
              Icon(
                Icons.calendar_today,
                size: 16.0,
                color: Theme.of(context).disabledColor,
              ),
              Text(getDateString(match.time)),
            ],
          ),
          Row(
            spacing: 4,
            children: [
              Icon(
                Icons.access_time,
                size: 16.0,
                color: Theme.of(context).disabledColor,
              ),
              Text(
                "${match.time.hour}:${match.time.minute.toString().padLeft(2, "0")}",
              ),
            ],
          ),
          Expanded(
            child: Row(
              spacing: 4,
              children: [
                Icon(Icons.location_on),
                Expanded(
                  child: Text(
                    match.homeTeam == hometeam
                        ? "Home"
                        : match.locationUrl.isEmpty
                        ? "TBD"
                        : match.locationUrl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
