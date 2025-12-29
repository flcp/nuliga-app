import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/match-result/match_result_game_result_row.dart';
import 'package:nuliga_app/pages/match-result/match_result_hero_element.dart';
import 'package:nuliga_app/pages/shared/action_bar_open_link_button.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/services/match_result_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class MatchResultPage extends StatelessWidget {
  final MatchResult matchResult;
  final String teamName;

  final matchResultService = MatchResultService();

  MatchResultPage({
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
            FutureBuilder(
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
                          (gameResult) => MatchResultGameResultRow(
                            gameResult: gameResult,
                            isHomeTeamHighlighted:
                                matchResult.homeTeamName == teamName,
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
