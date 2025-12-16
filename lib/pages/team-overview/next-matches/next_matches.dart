import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/team-overview/next-matches/next_matches_card.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class NextMatches extends StatelessWidget {
  final String matchesUrl;
  final FollowedClub team;

  final nextMatchesService = NextMatchesService();

  NextMatches({super.key, required this.matchesUrl, required this.team});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: FutureBuilder(
        future: nextMatchesService.getNextMatchesWithNextGamedaySeparate(
          matchesUrl,
          team.name,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: [
                AspectRatio(aspectRatio: 1, child: Card(elevation: 0)),
                AspectRatio(aspectRatio: 1, child: Card(elevation: 0)),
                AspectRatio(aspectRatio: 1, child: Card(elevation: 0)),
              ],
            );
          }

          final nextMatches = getDataOrDefault(snapshot, (next: [], later: []));

          final nextTwoMatches = nextMatches.next;
          final laterMatches = nextMatches.later;

          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...nextTwoMatches.map(
                (match) => NextMatchesCard(
                  team: team,
                  match: match,
                  highlighted: true,
                ),
              ),
              ...laterMatches.map(
                (match) => NextMatchesCard(
                  team: team,
                  match: match,
                  highlighted: false,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
