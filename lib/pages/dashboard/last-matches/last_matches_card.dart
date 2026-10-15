import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/services/matches/last-matches/model/match_result.dart';
import 'package:nuliga_app/pages/match-result/match_result_page.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';
import 'package:nuliga_app/pages/shared/surface_card.dart';

class LastMatchesCard extends StatelessWidget {
  const LastMatchesCard({
    super.key,
    required this.matchResult,
    required this.teamName,
  });

  final MatchResult matchResult;
  final String teamName;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () => navigateToMatchResult(context, matchResult, teamName),
      child: SurfaceCard(
        child: Padding(
          padding: EdgeInsets.all(Constants.bigCardPadding),
          child: Column(
            children: [
              Row(
                children: [
                  WinLossIndicator(
                    isTextDisplayed: true,
                    size: 10,
                    status: matchResult.getMatchStatusForTeam(teamName),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    matchResult
                        .getMatchStatusForTeam(teamName)
                        .localized(localization),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    matchResult.getEnemyTeamName(teamName),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "${matchResult.homeTeamMatchesWon.toString()} : ${matchResult.opponentTeamMatchesWon.toString()}",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Überall diese Struktur
void navigateToMatchResult(
  BuildContext context,
  MatchResult result,
  String teamName,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          MatchResultPage(matchResult: result, teamName: teamName),
    ),
  );
}
