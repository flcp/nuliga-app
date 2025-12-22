import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/match-result/match_result_game_result_row.dart';
import 'package:nuliga_app/pages/match-result/match_result_hero_element.dart';
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

          return Column(
            children: [
              MatchResultHeroElement(matchResult: matchResult),
              Expanded(
                child: ListView(
                  children: matchResultDetail.gameResults
                      .map(
                        (gameResult) =>
                            MatchResultGameResultRow(gameResult: gameResult),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
