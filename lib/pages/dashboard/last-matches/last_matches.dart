import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nuliga_app/l10n/app_localizations.dart';
import 'package:nuliga_app/services/followed-teams/followed_club.dart';
import 'package:nuliga_app/pages/dashboard/last-matches/last_matches_card.dart';
import 'package:nuliga_app/services/matches/last_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LastMatches extends StatelessWidget {
  final FollowedClub team;

  const LastMatches({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return SizedBox(
      height: 290,
      child: FutureBuilder(
        future: LastMatchesService.getLastMatchesForTeam(
          team.matchesUrl,
          team.name,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(l10n.loading);
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
                  (result) =>
                      LastMatchesCard(matchResult: result, teamName: team.name),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
