import 'package:flutter/material.dart';
import 'package:nuliga_app/services/followed-teams/followed_club.dart';
import 'package:nuliga_app/services/matches/next-matches/model/future_match.dart';
import 'package:nuliga_app/pages/shared/surface_card.dart';
import 'package:nuliga_app/pages/next-match/next_match_page.dart';
import 'package:nuliga_app/pages/dashboard/next-matches/next_matches_location_indicator.dart';
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
    return SquareSurfaceCard(
      onTap: () {
        navigateToUpcomingMatch(widget.match, widget.team.name);
      },
      titleTrailing: NextMatchesLocationIndicatorButton(
        match: widget.match,
        homeTeamName: widget.team.name,
      ),
      title: Date.getShortDateString(widget.match.time),
      highlighted: widget.highlighted,
      child: Text(
        getOpponent(widget.match, widget.team),
        style: Theme.of(context).textTheme.titleLarge,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
    );
  }

  void navigateToUpcomingMatch(FutureMatch match, String teamName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextMatchPage(match: match, teamName: teamName),
      ),
    );
  }

  String getOpponent(FutureMatch match, FollowedClub team) {
    final isHomeMatch = match.homeTeam == team.name;
    return isHomeMatch ? match.opponentTeam : match.homeTeam;
  }
}
