import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/match-result/match_result_page.dart';
import 'package:nuliga_app/pages/dashboard/last-matches/last_matches_card.dart';
import 'package:nuliga_app/services/last_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LastMatches extends StatelessWidget {
  final FollowedClub team;

  const LastMatches({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: FutureBuilder(
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
                    borderRadius: BorderRadius.circular(
                      Theme.of(context).cardTheme.shape
                              is RoundedRectangleBorder
                          ? (Theme.of(context).cardTheme.shape
                                    as RoundedRectangleBorder)
                                .borderRadius
                                .resolve(TextDirection.ltr)
                                .topLeft
                                .x
                          : 16.0,
                    ),
                    onTap: () => navigateToMatchResult(context, result),
                    child: LastMatchesCard(
                      matchResult: result,
                      teamName: team.name,
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }

  // TODO: überall diese Struktur
  void navigateToMatchResult(BuildContext context, MatchResult result) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MatchResultPage(matchResult: result, teamName: team.name),
      ),
    );
  }
}
