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
          SizedBox(
            width: 100,
            child: Text(
              "${match.time.day}.${match.time.month}.${match.time.year}",
            ),
          ),
          Text(
            "${match.time.hour}:${match.time.minute.toString().padLeft(2, "0")}",
          ),
        ],
      ),
      title: Text(
        match.homeTeam == hometeam ? match.opponentTeam : match.homeTeam,
      ),
      trailing: LocationIndicator(
        match: match,
        matchOverviewUrl: matchOverviewUrl,
      ),
    );
  }
}
