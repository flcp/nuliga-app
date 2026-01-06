import 'package:flutter/material.dart';
import 'package:nuliga_app/model/game_type.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/model/player.dart';
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
        padding: const EdgeInsets.all(Constants.pagePadding),
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

class GameTypeIcon extends StatelessWidget {
  final GameType gameType;

  const GameTypeIcon(this.gameType, {super.key});

  @override
  Widget build(BuildContext context) {
    final icons = switch (gameType) {
      GameType.md1 || GameType.md2 => [Icons.man, Icons.man],
      GameType.wd => [Icons.woman, Icons.woman],
      GameType.xd => [Icons.man, Icons.woman],
      GameType.ms1 || GameType.ms2 || GameType.ms3 => [Icons.man],
      GameType.ws => [Icons.woman],
    };

    return SizedBox(
      width: 28,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          if (icons.length > 1) ...[
            Positioned.directional(
              start: 6,
              textDirection: TextDirection.ltr,
              child: Icon(
                icons.last,
                size: 22,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
              ),
            ),
            Positioned.directional(
              start: 2,
              textDirection: TextDirection.ltr,
              top: 2,
              child: Icon(
                icons.first,
                size: 22,
                // color: Colors.red,
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
              ),
            ),
            Positioned.directional(
              start: 2,
              textDirection: TextDirection.ltr,

              child: Icon(
                icons.first,
                size: 22,
                // color: Colors.red,
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
              ),
            ),
          ],
          Icon(
            icons.first,
            size: 22,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
          ),
        ],
      ),
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
