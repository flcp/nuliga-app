import 'package:flutter/material.dart';
import 'package:nuliga_app/model/game_result.dart';
import 'package:nuliga_app/model/match_result.dart';

class MatchResultScorePill extends StatelessWidget {
  final MatchResult matchResult;
  final String teamName;

  const MatchResultScorePill({
    super.key,
    required this.matchResult,
    required this.teamName,
  });

  @override
  Widget build(BuildContext context) {
    final leftScore = matchResult.homeTeamMatchesWon;
    final rightScore = matchResult.opponentTeamMatchesWon;

    return ScorePill(
      status: matchResult.getMatchStatusForTeam(teamName),
      leftScore: leftScore,
      rightScore: rightScore,
    );
  }
}

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
      status: status ? MatchResultStatus.Win : MatchResultStatus.Loss,
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
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          WinLossIndicator(size: 10, status: status),
          SizedBox(width: 8),
          Text(
            '$leftScore-$rightScore',

            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class WinLossIndicator extends StatelessWidget {
  const WinLossIndicator({super.key, required this.size, required this.status});

  final double size;
  final MatchResultStatus status;

  @override
  Widget build(BuildContext context) {
    final Color color = switch (status) {
      MatchResultStatus.Win => const Color.fromARGB(255, 140, 227, 145),
      MatchResultStatus.Loss => const Color.fromARGB(255, 255, 147, 137),
      MatchResultStatus.Draw => Colors.grey.shade300,
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
