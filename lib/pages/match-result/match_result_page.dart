import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/match-result/match_result_game_result_row.dart';
import 'package:nuliga_app/services/match_result_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class MatchResultPage extends StatelessWidget {
  final MatchResult matchResult;

  final matchResultService = MatchResultService();

  MatchResultPage({required this.matchResult, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ergebnis")),
      body: FutureBuilder(
        future: matchResultService.getMatchResultDetails(
          matchResult.resultDetailUrl,
        ),
        builder: (context, asyncSnapshot) {
          final matchResultDetail = getDataOrDefault(asyncSnapshot, null);
          if (matchResultDetail == null) {
            // TODO: fix
            return Text("ERROR");
          }

          final titleStyle = Theme.of(context).textTheme.displaySmall;

          return ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(matchResult.homeTeam, style: titleStyle),
                  ),
                  Text(
                    matchResult.homeTeamMatchesWon.toString(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(" - ", style: Theme.of(context).textTheme.displaySmall),
                  Text(
                    matchResult.opponentTeamMatchesWon.toString(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),

                  Expanded(
                    child: Text(matchResult.opponentTeam, style: titleStyle),
                  ),
                ],
              ),
              ...matchResultDetail.gameResults.map(
                (gameResult) =>
                    MatchResultGameResultRow(gameResult: gameResult),
              ),
            ],
          );
        },
      ),
    );
  }
}
