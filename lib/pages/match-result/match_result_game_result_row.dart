import 'package:flutter/material.dart';
import 'package:nuliga_app/model/game_result.dart';
import 'package:nuliga_app/model/game_type.dart';
import 'package:nuliga_app/model/player.dart';

class MatchResultGameResultRow extends StatelessWidget {
  const MatchResultGameResultRow({super.key, required this.gameResult});

  final GameResult gameResult;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface.withAlpha(160);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 0,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${gameResult.homeSetsWon} - ${gameResult.opponentSetsWon}",

                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
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
                          (set) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              "${set.homeScore.toString()} - ${set.opponentScore.toString()}",
                            ),
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
        ? Text(
            players.map((player) => player.lastName).join(" / "),
            textAlign: align,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: didPlayersWin ? textColor : greyedOutColor,
              fontWeight: didPlayersWin ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
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
