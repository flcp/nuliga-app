import 'package:flutter/material.dart';
import 'package:nuliga_app/model/game_result.dart';
import 'package:nuliga_app/model/game_type.dart';
import 'package:nuliga_app/model/player.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';

class MatchResultGameResultRow extends StatelessWidget {
  const MatchResultGameResultRow({
    super.key,
    required this.gameResult,
    required this.isHomeTeamHighlighted,
  });

  final bool isHomeTeamHighlighted;
  final GameResult gameResult;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface.withAlpha(160);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(Constants.smallCardPadding),
        child: ExpansionTile(
          shape: Border.all(color: Colors.transparent),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gameResult.gameType.displayName,
                style: TextStyle(color: textColor, fontSize: 12),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PlayersText(
                      players: gameResult.homePlayers,
                      gameType: gameResult.gameType,
                      didPlayersWin: gameResult.homeTeamWon,
                    ),
                  ),

                  GameResultScorePill(
                    gameResult: gameResult,
                    isHomeTeamHighlighted: isHomeTeamHighlighted,
                  ),
                  Expanded(
                    child: PlayersText(
                      align: TextAlign.right,
                      players: gameResult.opponentPlayers,
                      gameType: gameResult.gameType,
                      didPlayersWin: !gameResult.homeTeamWon,
                    ),
                  ),
                ],
              ),
            ],
          ),
          children: [
            // TODO: extract to own screen
            DefaultTextStyle(
              style: TextStyle(color: textColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Column(
                      children: gameResult.homePlayers
                          .map((player) => Text(player.getFullname()))
                          .toList(),
                    ),
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: gameResult.sets
                        .map(
                          (set) => Text(
                            "${set.homeScore.toString()} - ${set.opponentScore.toString()}",
                          ),
                        )
                        .toList(),
                  ),
                  Flexible(
                    child: Column(
                      children: gameResult.opponentPlayers
                          .map((player) => Text(player.getFullname()))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayersText extends StatelessWidget {
  final List<Player> players;
  final GameType gameType;
  final bool didPlayersWin;
  final TextAlign align;

  const PlayersText({
    super.key,
    required this.players,
    required this.gameType,
    required this.didPlayersWin,
    this.align = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    final greyedOutColor = Theme.of(
      context,
    ).colorScheme.onSurface.withAlpha(180);
    final textColor = Theme.of(context).colorScheme.onSurface;

    return gameType.isDoubles()
        ? Column(
            children: players
                .map(
                  (player) => Text(
                    player.lastName,
                    textAlign: align,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: didPlayersWin ? textColor : greyedOutColor,
                      fontWeight: didPlayersWin
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                )
                .toList(),
          )
        : Text(
            players.first.getFullname(),
            textAlign: align,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: didPlayersWin ? textColor : greyedOutColor,
              fontWeight: didPlayersWin ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          );
  }
}
