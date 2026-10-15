import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/services/followed-teams/model/followed_club.dart';
import 'package:nuliga_app/pages/dashboard/last-matches/last_matches_card.dart';
import 'package:nuliga_app/services/matches/last-matches/model/match_result.dart';
import 'package:nuliga_app/services/matches/last_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LastMatches extends StatefulWidget {
  final FollowedClub team;

  const LastMatches({super.key, required this.team});

  @override
  State<LastMatches> createState() => _LastMatchesState();
}

class _LastMatchesState extends State<LastMatches> {
  late Future<List<MatchResult>> _lastMatchesFuture;

  @override
  void initState() {
    super.initState();
    _lastMatchesFuture = LastMatchesService.getLastMatchesForTeam(
      widget.team.matchesUrl,
      widget.team.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return SizedBox(
      height: 290,
      child: FutureBuilder(
        future: _lastMatchesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(localization.loading);
          }

          final matchResults = getDataOrEmptyList(snapshot).reversed.toList();
          final lastThreeMatchResults = matchResults.getRange(
            0,
            min(2, matchResults.length),
          );

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 0,
            children: lastThreeMatchResults
                .map(
                  (result) => LastMatchesCard(
                    matchResult: result,
                    teamName: widget.team.name,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
