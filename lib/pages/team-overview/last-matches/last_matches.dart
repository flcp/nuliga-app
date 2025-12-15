import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/services/last_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LastMatches extends StatelessWidget {
  final FollowedClub team;

  const LastMatches({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LastMatchesService.getLastMatchesForTeam(
        team.matchesUrl,
        team.name,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("loading");
        }

        final matchResults = getDataOrEmptyList(snapshot).reversed.toList();
        final lastThreeMatchResults = matchResults.getRange(
          0,
          min(3, matchResults.length),
        );

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 0,
          children: lastThreeMatchResults
              .map(
                (result) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          result.homeTeam,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.right,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          result.homeTeamMatchesWon.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          result.opponentTeamMatchesWon.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          result.opponentTeam,
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
