import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/model/match_result_detail.dart';
import 'package:nuliga_app/services/match_result_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class MatchResultPage extends StatelessWidget {
  final MatchResult matchResult;

  const MatchResultPage({required this.matchResult, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(title: Text("Ergebnis")),
        body: FutureBuilder(
          future: MatchResultService.getMatchResultDetails(
            matchResult.resultDetailUrl,
          ),
          builder: (context, asyncSnapshot) {
            final matchResultDetail = getDataOrDefault(asyncSnapshot, null);
            if (matchResultDetail == null) {
              // TODO: fix
              return Text("ERROR");
            }

            return Column(
              children: [
                Text("MD1"),
                MatchResultGameResultRow(gameResult: matchResultDetail.MD1),
                Text("MD2"),
                MatchResultGameResultRow(gameResult: matchResultDetail.MD2),
                Text("WD"),
                MatchResultGameResultRow(gameResult: matchResultDetail.WD),
                Text("XD"),
                MatchResultGameResultRow(gameResult: matchResultDetail.XD),
                Text("MS1"),
                MatchResultGameResultRow(gameResult: matchResultDetail.MS1),
                Text("MS2"),
                MatchResultGameResultRow(gameResult: matchResultDetail.MS2),
                Text("MS3"),
                MatchResultGameResultRow(gameResult: matchResultDetail.MS3),
                Text("WS"),
                MatchResultGameResultRow(gameResult: matchResultDetail.WS),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MatchResultGameResultRow extends StatelessWidget {
  const MatchResultGameResultRow({super.key, required this.gameResult});

  final GameResult gameResult;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: gameResult.homePlayerNames
              .map((name) => Text(name))
              .toList(),
        ),
        Column(
          children: [
            Text(
              "${gameResult.homeSetsWon.toString()} - ${gameResult.opponentSetsWon.toString()}",
            ),
            ...gameResult.sets.map(
              (set) => Text(
                "${set.homeScore.toString()} - ${set.opponentScore.toString()}",
              ),
            ),
          ],
        ),
        Column(
          children: gameResult.opponentPlayerNames
              .map((name) => Text(name))
              .toList(),
        ),
      ],
    );
  }
}
