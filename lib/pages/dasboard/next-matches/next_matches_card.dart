import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/dasboard/league-info/league_info_card.dart';
import 'package:nuliga_app/pages/next-match/next_match_page.dart';
import 'package:nuliga_app/pages/dasboard/next-matches/next_matches_location_indicator.dart';
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
    return LeagueInfoCard(
      title: Date.getShortDateString(widget.match.time),
      child: Stack(
        children: [
          Text(
            getOpponent(widget.match, widget.team),
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.clip,
            maxLines: 3,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.transparent),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                    blurRadius: 10.0,
                    spreadRadius: 10.0,
                  ),
                ],
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
              ),

              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: NextMatchesLocationIndicatorButton(
                  match: widget.match,
                  homeTeamName: widget.team.name,
                ),
              ),
            ),
          ),
        ],
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
