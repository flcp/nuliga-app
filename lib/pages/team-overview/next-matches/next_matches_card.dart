import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/team-details/next-matches/next_matches_details_list_location_indicator.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';

class NextMatchesCard extends StatelessWidget {
  final FollowedClub team;
  final FutureMatch match;
  final bool highlighted;

  const NextMatchesCard({
    super.key,
    required this.team,
    required this.match,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = highlighted
        ? Theme.of(context).primaryColorLight
        : Theme.of(context).cardTheme.color;

    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TeamDetailsPage(team: team)),
        ),
        child: Card(
          color: backgroundColor,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    getOpponent(match, team),
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${match.time.day}.${match.time.month}.${match.time.year}",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    NextMatchesDetailsLocationIndicator(
                      match: match,
                      homeTeamName: team.name,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getOpponent(FutureMatch match, FollowedClub team) {
    final isHomeMatch = match.homeTeam == team.name;
    return isHomeMatch ? match.opponentTeam : match.homeTeam;
  }
}
