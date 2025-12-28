import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/match-result/match_result_page.dart';
import 'package:nuliga_app/pages/team-overview/last-matches/last_matches_card.dart';
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
                (result) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MatchResultPage(
                          matchResult: result,
                          teamName: team.name,
                        ),
                      ),
                    );
                  },
                  child: LastMatchesCard(matchResult: result, homeTeam: team),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
