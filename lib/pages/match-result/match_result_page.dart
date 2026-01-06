import 'package:flutter/material.dart';
import 'package:nuliga_app/model/game_result.dart';
import 'package:nuliga_app/model/game_type.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/model/player.dart';
import 'package:nuliga_app/pages/match-result/game_result_detail.dart';
import 'package:nuliga_app/pages/match-result/game_type_icon.dart';
import 'package:nuliga_app/pages/match-result/match_result_hero_element.dart';
import 'package:nuliga_app/pages/shared/action_bar_open_link_button.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';
import 'package:nuliga_app/pages/shared/surface_card.dart';
import 'package:nuliga_app/services/match_result_service.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Ergebnis"),
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
          return Text("Nothing to display");
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
                        return GameResultDetail(gameResult);
                      },
                    ),
                    titleLeading: GameTypeIcon(gameResult.gameType),
                    title: gameResult.gameType.displayName,
                    titleTrailing: WinLossIndicator(
                      size: 12,
                      status: isHomeTeam
                          ? gameResult.getMatchStatusForHomeTeam()
                          : gameResult.getMatchStatusForOpponentTeam(),
                    ),
                    child: Column(
                      children: [
                        MatchResultGameResultRow(
                          players: gameResult.homePlayers,
                          setsWon: gameResult.homeSetsWon,
                        ),
                        MatchResultGameResultRow(
                          players: gameResult.opponentPlayers,
                          setsWon: gameResult.opponentSetsWon,
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

class MatchResultGameResultRow extends StatelessWidget {
  const MatchResultGameResultRow({
    super.key,
    required this.players,
    required this.setsWon,
  });

  final List<Player> players;
  final int setsWon;

  @override
  Widget build(BuildContext context) {
    final isWinner = setsWon == 2;

    final playerText = players.length > 1
        ? players.map((p) => p.lastName).join(" / ")
        : players.first.getFullname();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          playerText,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: isWinner ? FontWeight.w900 : FontWeight.normal,
          ),
        ),
        Text(setsWon.toString(), style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}
