import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_details_list_location_indicator.dart';

class NextMatchesOverviewListCard extends StatelessWidget {
  final FutureMatch match;
  final FollowedClub team;

  const NextMatchesOverviewListCard({
    super.key,
    required this.match,
    required this.team,
  });

  static const iconSize = 20.0;
  static var color = Colors.grey.shade700;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Center(child: Text(match.homeTeam, softWrap: true)),
              ),
              Text(" – "),
              Expanded(
                child: Center(child: Text(match.opponentTeam, softWrap: true)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, size: iconSize, color: color),
                  SizedBox(width: 8),
                  Text(
                    "${match.time.day}.${match.time.month}.${match.time.year}",
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.access_time, size: iconSize, color: color),
                  SizedBox(width: 8),

                  Text(
                    "${match.time.hour}:${match.time.minute.toString().padLeft(2, "0")}",
                  ),
                ],
              ),

              Row(
                children: [
                  Icon(Icons.location_on, size: iconSize, color: color),
                  SizedBox(width: 8),

                  NextMatchesDetailsLocationIndicator(
                    match: match,
                    homeTeamName: team.name,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
