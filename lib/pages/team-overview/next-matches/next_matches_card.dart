import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/future_match.dart';
import 'package:nuliga_app/pages/shared/next_matches_location_indicator.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/services/shared/date.dart';

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
    final cardColor1 = highlighted
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.primaryFixed;
    final cardColor2 = Color.lerp(
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.tertiary,
      0.75,
    )!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeamDetailsPage(team: team),
            ),
          ),
          child: Card(
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cardColor1, cardColor2],
                  stops: [0.4, 1],
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        getOpponent(match, team),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getShortDateString(match.time),
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
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
        ),
      ),
    );
  }

  String getOpponent(FutureMatch match, FollowedClub team) {
    final isHomeMatch = match.homeTeam == team.name;
    return isHomeMatch ? match.opponentTeam : match.homeTeam;
  }
}
