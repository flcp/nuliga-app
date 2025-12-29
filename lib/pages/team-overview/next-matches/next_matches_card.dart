import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/next-match/next_match_page.dart';
import 'package:nuliga_app/pages/team-overview/next-matches/next_matches_location_indicator.dart';
import 'package:nuliga_app/services/shared/date.dart';

class NextMatchesCard extends StatefulWidget {
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
  State<NextMatchesCard> createState() => _NextMatchesCardState();
}

class _NextMatchesCardState extends State<NextMatchesCard> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        onTap: () => navigateToUpcomingMatch(widget.match),
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    getOpponent(widget.match, widget.team),
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getShortDateString(widget.match.time),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    NextMatchesLocationIndicatorButton(
                      match: widget.match,
                      homeTeamName: widget.team.name,
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

  void navigateToUpcomingMatch(FutureMatch match) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NextMatchPage(match: match)),
    );
  }

  String getOpponent(FutureMatch match, FollowedClub team) {
    final isHomeMatch = match.homeTeam == team.name;
    return isHomeMatch ? match.opponentTeam : match.homeTeam;
  }
}
