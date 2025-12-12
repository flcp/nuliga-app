import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_list_location_indicator.dart';

class NextMatchesListItem extends StatelessWidget {
  final FutureMatch match;
  final String hometeam;
  final bool highlighted;
  final String matchOverviewUrl;
  final bool displayOnlyOpponentName;

  static const double spacingSubtitleBlocks = 16.0;
  static const double spacingSubtitleIcons = 8.0;

  const NextMatchesListItem({
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
      selected: highlighted,
      selectedColor: Theme.of(context).textTheme.bodyMedium!.color,
      textColor: Theme.of(context).disabledColor.withAlpha(130),
      subtitle: Wrap(
        children: [
          const Icon(Icons.calendar_today, size: 16.0, color: Colors.grey),
          const SizedBox(width: spacingSubtitleIcons),
          SizedBox(
            width: 90,
            child: Text(
              "${match.time.day}.${match.time.month}.${match.time.year}",
            ),
          ),
          const Icon(Icons.access_time, size: 16.0, color: Colors.grey),
          const SizedBox(width: spacingSubtitleIcons),
          Text(
            "${match.time.hour}:${match.time.minute.toString().padLeft(2, "0")}",
          ),
          const SizedBox(width: spacingSubtitleBlocks),
          const Icon(Icons.location_on, size: 16.0, color: Colors.grey),
          const SizedBox(width: spacingSubtitleIcons),
          Text(match.homeTeam == hometeam ? "Heimspiel" : "Auswärts"),
        ],
      ),
      title: MatchupIndicator(
        match: match,
        hometeam: hometeam,
        displayOnlyOpponentName: displayOnlyOpponentName,
      ),
      trailing: LocationIndicator(
        match: match,
        matchOverviewUrl: matchOverviewUrl,
      ),
    );
  }
}

class MatchupIndicator extends StatelessWidget {
  const MatchupIndicator({
    super.key,
    required this.match,
    required this.hometeam,
    required this.displayOnlyOpponentName,
  });

  final FutureMatch match;
  final String hometeam;
  final bool displayOnlyOpponentName;

  @override
  Widget build(BuildContext context) {
    if (displayOnlyOpponentName) {
      final isHomeMatch = match.homeTeam == hometeam;

      return Text(isHomeMatch ? match.opponentTeam : match.homeTeam);
    }

    return Text("${match.homeTeam} – ${match.opponentTeam}");
  }
}
