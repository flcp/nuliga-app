import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result_detail.dart';

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
    return ExpansionTile(
      shape: const Border(), // removes expanded divider
      childrenPadding: EdgeInsets.symmetric(horizontal: 8),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          Expanded(
            child: Column(
              children: gameResult.homePlayerNames
                  .map(
                    (name) => Text(
                      name,
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
              children: gameResult.opponentPlayerNames
                  .map(
                    (name) => Text(
                      name,
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
    );
  }
}
