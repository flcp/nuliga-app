import 'package:flutter/material.dart';
import 'package:nuliga_app/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.resultCount(1)),
        actions: [ActionBarOpenLinkButton(url: matchResult.resultDetailUrl)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.pagePadding),
        child: Column(
          children: [
            MatchResultHeroElement(
              matchResult: matchResult,
              teamName: teamName,
            ),
            MatchResultPageContent(
              matchResult: matchResult,
              teamName: teamName,
            ),
          ],
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
    final l10n = AppLocalizations.of(context)!;

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
          return Text(l10n.nothingToDisplay);
        }

        return Expanded(
          child: ListView(
            children: matchResultDetail.gameResults
                .map(
                  (gameResult) => SurfaceCard(
                    padding: const EdgeInsets.all(Constants.bigCardPadding),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return GameResultDetail(
                          gameResult: gameResult,
                          homeTeamName: matchResult.homeTeamName,
                          opponentTeamName: matchResult.opponentTeamName,
                        );
                      },
                    ),
                    titleLeading: GameTypeIcon(gameResult.gameType),
                    title: gameResult.gameType.localize(l10n),
                    titleTrailing: WinLossIndicator(
                      size: 12,
                      status: isHomeTeam
                          ? gameResult.getMatchStatusForHomeTeam()
                          : gameResult.getMatchStatusForOpponentTeam(),
                    ),
                    child: Column(
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  GameResultPlayerText(
                                    players: gameResult.homePlayers,
                                    isWinner: gameResult.homeTeamWon,
                                  ),
                                  GameResultPlayerText(
                                    players: gameResult.opponentPlayers,
                                    isWinner: !gameResult.homeTeamWon,
                                  ),
                                ],
                              ),
                            ),
                            ...gameResult.sets.map(
                              (set) => Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    set.homeScore.toString(),
                                    style: TextStyle(
                                      fontWeight: set.didHomeTeamWin()
                                          ? FontWeight.w900
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    set.opponentScore.toString(),
                                    style: TextStyle(
                                      fontWeight: set.didOpponentTeamWin()
                                          ? FontWeight.w900
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
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
  });

  final List<Player> players;
  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    final playerText = players.length > 1
        ? players.map((p) => p.lastName).join(" / ")
        : players.first.getFullname();

    return Text(
      playerText,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
        fontWeight: isWinner ? FontWeight.w900 : FontWeight.normal,
      ),
    );
  }
}
