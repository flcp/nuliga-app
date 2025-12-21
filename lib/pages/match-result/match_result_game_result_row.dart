import 'package:flutter/material.dart';
import 'package:nuliga_app/model/game_result.dart';

class MatchResultGameResultRow extends StatelessWidget {
  const MatchResultGameResultRow({
    super.key,
    required this.gameResult,
    required this.title,
  });

  final GameResult gameResult;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        shape: const Border(), // removes expanded divider
        childrenPadding: EdgeInsets.symmetric(horizontal: 8),
        title: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(gameResult.gameType.displayName),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: gameResult.homePlayers
                        .map(
                          (player) => Text(
                            player.getFullname(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: gameResult.homeTeamWon
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(
                  gameResult.homeSetsWon.toString(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(" - ", style: Theme.of(context).textTheme.displaySmall),
                Text(
                  gameResult.opponentSetsWon.toString(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Expanded(
                  child: Column(
                    children: gameResult.opponentPlayers
                        .map(
                          (player) => Text(
                            player.getFullname(),
                            style: TextStyle(
                              fontSize: 12,

                              fontWeight: !gameResult.homeTeamWon
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: gameResult.sets
                  .map(
                    (set) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${set.homeScore.toString()} - ${set.opponentScore.toString()}",
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
