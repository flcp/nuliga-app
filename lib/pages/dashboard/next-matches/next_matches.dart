import 'package:flutter/material.dart';
import 'package:nuliga_app/services/followed-teams/followed_club.dart';
import 'package:nuliga_app/pages/dashboard/next-matches/next_matches_card.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/matches/next_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class NextMatches extends StatelessWidget {
  final String matchesUrl;
  final FollowedClub team;

  final nextMatchesService = NextMatchesService();

  NextMatches({super.key, required this.matchesUrl, required this.team});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: FutureBuilder(
        future: nextMatchesService.getNextMatchesWithNextGamedaySeparate(
          matchesUrl,
          team.name,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: Constants.bigCardPadding,
              ),
              scrollDirection: Axis.horizontal,
              children: [
                AspectRatio(aspectRatio: 1, child: Card(elevation: 0)),
                SizedBox(width: Constants.bigCardListSpacing),
                AspectRatio(aspectRatio: 1, child: Card(elevation: 0)),
                SizedBox(width: Constants.bigCardListSpacing),
                AspectRatio(aspectRatio: 1, child: Card(elevation: 0)),
              ],
            );
          }

          final nextMatches = getDataOrDefault(snapshot, (next: [], later: []));

          final nextTwoMatches = nextMatches.next;
          final laterMatches = nextMatches.later;

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: Constants.bigCardPadding),

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
