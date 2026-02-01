import 'package:flutter/material.dart';
import 'package:nuliga_app/services/matches/last-matches/model/match_result.dart';
import 'package:nuliga_app/pages/match-result/match_result_page.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';
import 'package:nuliga_app/pages/shared/surface_card.dart';
import 'package:nuliga_app/services/shared/date.dart';

class LastMatchesCard extends StatelessWidget {
  const LastMatchesCard({
    super.key,
    required this.matchResult,
    required this.teamName,
  });

  final MatchResult matchResult;
  final String teamName;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.fromLTRB(
        Constants.bigCardPadding,
        Constants.smallCardPadding,
        4,
        Constants.smallCardPadding,
      ),
      title: Date.getDateString(matchResult.time),
      titleTrailing: WinLossIndicator(
        isTextDisplayed: true,
        size: 10,
        status: matchResult.getMatchStatusForTeam(teamName),
      ),
      onTap: () => navigateToMatchResult(context, matchResult, teamName),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MatchResultText(matchResult.homeTeamName),
                MatchResultText(matchResult.opponentTeamName),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MatchResultText(matchResult.homeTeamMatchesWon.toString()),
              MatchResultText(matchResult.opponentTeamMatchesWon.toString()),
            ],
          ),
        ],
      ),
    );
  }
}

// TODO: Überall diese Struktur
void navigateToMatchResult(
  BuildContext context,
  MatchResult result,
  String teamName,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          MatchResultPage(matchResult: result, teamName: teamName),
    ),
  );
}

class MatchResultText extends StatelessWidget {
  const MatchResultText(this.teamName, {super.key});

  final String teamName;

  @override
  Widget build(BuildContext context) {
    return Text(
      teamName,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
