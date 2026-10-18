import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/services/match-result/model/game_type.dart';
import 'package:nuliga_app/services/matches/last-matches/model/match_result.dart';
import 'package:nuliga_app/services/match-result/model/player.dart';
import 'package:nuliga_app/pages/match-result/game_result_detail.dart';
import 'package:nuliga_app/pages/match-result/game_type_icon.dart';
import 'package:nuliga_app/pages/match-result/match_result_hero_element.dart';
import 'package:nuliga_app/pages/shared/action_bar_open_link_button.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';
import 'package:nuliga_app/pages/shared/surface_card.dart';
import 'package:nuliga_app/services/match-result/match_result_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class MatchResultPage extends StatelessWidget {
  final MatchResult matchResult;
  final String teamName;

  const MatchResultPage({
    required this.teamName,
    required this.matchResult,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.resultCount(1)),
        actions: [ActionBarOpenLinkButton(url: matchResult.resultDetailUrl)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.pagePadding),
        child: MatchResultPageContent(
          matchResult: matchResult,
          teamName: teamName,
        ),
      ),
    );
  }
}

class MatchResultPageContent extends StatelessWidget {
  final matchResultService = MatchResultService();

  MatchResultPageContent({
    super.key,
    required this.matchResult,
    required this.teamName,
  });

  final MatchResult matchResult;
  final String teamName;

  @override
  Widget build(BuildContext context) {
    final isHomeTeam = matchResult.homeTeamName == teamName;
    final localization = AppLocalizations.of(context)!;
    final infoColor = Theme.of(context).colorScheme.onSurface.withAlpha(160);
    final subtitleStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: infoColor);

    return FutureBuilder(
      future: matchResultService.getMatchResultDetails(
        matchResult.resultDetailUrl,
      ),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        }

        final matchResultDetail = getDataOrDefault(asyncSnapshot, null);
        if (matchResultDetail == null) {
          return Text(localization.nothingToDisplay);
        }

        return ListView(
          children: [
            MatchResultHeroElement(
              matchResult: matchResult,
              teamName: teamName,
              gameResults: matchResultDetail.gameResults,
            ),
            SizedBox(height: 32),

            ...matchResultDetail.gameResults.map((gameResult) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SurfaceCard(
                  padding: const EdgeInsets.all(Constants.bigCardPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          WinLossIndicator(
                            size: 8,
                            status: isHomeTeam
                                ? gameResult.getMatchStatusForHomeTeam()
                                : gameResult.getMatchStatusForOpponentTeam(),
                          ),
                          SizedBox(width: 8),
                          Text(
                            isHomeTeam
                                ? gameResult
                                      .getMatchStatusForHomeTeam()
                                      .localized(localization)
                                : gameResult
                                      .getMatchStatusForOpponentTeam()
                                      .localized(localization),
                            style: subtitleStyle,
                          ),
                          SizedBox(width: 8),
                          Text("·"),
                          SizedBox(width: 8),
                          GameTypeIcon(gameResult.gameType),
                          Text(
                            gameResult.gameType.localize(localization),
                            style: subtitleStyle,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: GameResultPlayerText(
                              players: gameResult.homePlayers,
                              isWinner: gameResult.homeTeamWon,
                              isLeftSide: true,
                            ),
                          ),
                          Column(
                            children: gameResult.sets
                                .map(
                                  (set) => Text(
                                    "${set.homeScore}:${set.opponentScore}",
                                  ),
                                )
                                .toList(),
                          ),
                          Expanded(
                            child: GameResultPlayerText(
                              players: gameResult.opponentPlayers,
                              isWinner: !gameResult.homeTeamWon,
                              isLeftSide: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class GameResultPlayerText extends StatelessWidget {
  const GameResultPlayerText({
    super.key,
    required this.players,
    required this.isWinner,
    required this.isLeftSide,
  });

  final List<Player> players;
  final bool isWinner;
  final bool isLeftSide;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isLeftSide
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: players
          .map(
            (player) => Text(
              player.getFullname(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: isWinner ? FontWeight.w900 : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
          .toList(),
    );
  }
}
