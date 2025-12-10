import 'package:flutter/material.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_list_location_indicator.dart';

class NextMatchesListItem extends StatelessWidget {
  final FutureMatch match;
  final String hometeam;
  final bool highlighted;
  final String matchOverviewUrl;

  const NextMatchesListItem({
    super.key,
    required this.match,
    required this.hometeam,
    required this.highlighted,
    required this.matchOverviewUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: highlighted,
      subtitle: Row(
        children: [
          const Icon(Icons.calendar_today, size: 16.0, color: Colors.grey),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 90,
            child: Text(
              "${match.time.day}.${match.time.month}.${match.time.year}",
            ),
          ),
          const Icon(Icons.access_time, size: 16.0, color: Colors.grey),
          const SizedBox(width: 8.0),
          Text(
            "${match.time.hour}:${match.time.minute.toString().padLeft(2, "0")}",
          ),
          const SizedBox(width: 16.0),
          const Icon(Icons.location_on, size: 16.0, color: Colors.grey),
          const SizedBox(width: 8.0),
          Text(match.homeTeam == hometeam ? "Heimspiel" : "Auswärts"),
        ],
      ),
      title: Text(
        match.homeTeam == hometeam ? match.opponentTeam : match.homeTeam,
        style: TextStyle(
          fontWeight: highlighted ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: LocationIndicator(
        match: match,
        matchOverviewUrl: matchOverviewUrl,
      ),
    );
  }
}
