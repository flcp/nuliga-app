import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/pages/match-result/game_type_icon.dart';
import 'package:nuliga_app/services/match-result/model/game_result.dart';
import 'package:nuliga_app/services/match-result/model/game_type.dart';
import 'package:nuliga_app/services/matches/last-matches/model/match_result.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';
import 'package:nuliga_app/services/shared/date.dart';

class MatchResultHeroElement extends StatelessWidget {
  const MatchResultHeroElement({
    super.key,
    required this.matchResult,
    required this.gameResults,
    required this.teamName,
  });

  final MatchResult matchResult;
  final String teamName;
  final List<GameResult> gameResults;

  @override
  Widget build(BuildContext context) {
    final date = context.getDate();
    final infoColor = Theme.of(context).colorScheme.onSurface.withAlpha(160);
    final subtitleStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: infoColor);
    final localization = AppLocalizations.of(context)!;

    return Column(
      spacing: 24,
      children: [
        Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WinLossIndicator(
              size: 16,
              status: matchResult.getMatchStatusForTeam(teamName),
            ),
            Expanded(
              child: Text(
                matchResult
                    .getMatchStatusForTeam(teamName)
                    .localized(localization),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: .bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              matchResult.isHomeTeam(teamName)
                  ? localization.homeGame_short
                  : localization.awayGame_short,
              style: subtitleStyle,
            ),
            Text("·"),
            Text(
              date.getLongDateStringWithoutYear(matchResult.time),
              style: subtitleStyle,
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                matchResult.homeTeamName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              "${matchResult.homeTeamMatchesWon}:${matchResult.opponentTeamMatchesWon}",
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w800),
            ),
            Expanded(
              child: Text(
                matchResult.opponentTeamName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(localization.won, style: subtitleStyle),
                ...gameResults
                    .where((gameResult) => gameResult.homeTeamWon)
                    .map(
                      (gameResult) => Row(
                        children: [
                          GameTypeIcon(gameResult.gameType),
                          Text(
                            gameResult.gameType.localize(localization),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(localization.won, style: subtitleStyle),
                ...gameResults
                    .where((gameResult) => !gameResult.homeTeamWon)
                    .map(
                      (gameResult) => Row(
                        children: [
                          Text(
                            gameResult.gameType.localize(localization),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          GameTypeIcon(gameResult.gameType),
                        ],
                      ),
                    ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
