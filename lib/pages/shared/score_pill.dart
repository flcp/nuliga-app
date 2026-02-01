import 'package:flutter/material.dart';
import 'package:nuliga_app/services/match-result/model/game_result.dart';
import 'package:nuliga_app/services/matches/last-matches/model/match_result.dart';

// TODO: delete
class GameResultScorePill extends StatelessWidget {
  const GameResultScorePill({
    super.key,
    required this.gameResult,
    required this.isHomeTeamHighlighted,
  });

  final bool isHomeTeamHighlighted;
  final GameResult gameResult;

  @override
  Widget build(BuildContext context) {
    final status = gameResult.homeTeamWon == isHomeTeamHighlighted;

    return ScorePill(
      leftScore: gameResult.homeSetsWon,
      rightScore: gameResult.opponentSetsWon,
      status: status ? MatchResultStatus.win : MatchResultStatus.loss,
    );
  }
}

class ScorePill extends StatelessWidget {
  const ScorePill({
    super.key,
    required this.status,
    required this.leftScore,
    required this.rightScore,
  });

  final MatchResultStatus status;
  final int leftScore;
  final int rightScore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          WinLossIndicator(size: 10, status: status),
          SizedBox(width: 8),
          Text(
            '$leftScore : $rightScore',

            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class WinLossIndicator extends StatelessWidget {
  const WinLossIndicator({
    super.key,
    required this.size,
    required this.status,
    this.isTextDisplayed = false,
  });

  final double size;
  final MatchResultStatus status;
  final bool isTextDisplayed;

  @override
  Widget build(BuildContext context) {
    final Color color = switch (status) {
      MatchResultStatus.win => const Color.fromARGB(255, 140, 227, 145),
      MatchResultStatus.loss => const Color.fromARGB(255, 255, 147, 137),
      MatchResultStatus.draw => Colors.grey.shade300,
      _ => Colors.grey,
    };

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.0),
        color: color,
      ),
    );
  }
}
