import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/match-result/match_result_page.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';
import 'package:nuliga_app/services/last_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LastMatchesDetailsList extends StatefulWidget {
  final String matchOverviewUrl;
  final String teamName;

  const LastMatchesDetailsList({
    super.key,
    required this.matchOverviewUrl,
    required this.teamName,
  });

  @override
  State<LastMatchesDetailsList> createState() => _LastMatchesDetailsListState();
}

class _LastMatchesDetailsListState extends State<LastMatchesDetailsList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LastMatchesService.getLastMatchesForTeam(
        widget.matchOverviewUrl,
        widget.teamName,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        }

        final matchResults = getDataOrEmptyList(snapshot).reversed;

        return ListView(
          children: matchResults.map((result) {
            return ListTile(
              onTap: () => goToMatchResult(result, widget.teamName),
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              trailing: Icon(Icons.chevron_right),
              horizontalTitleGap: 0,
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      result.homeTeamName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: result.isHomeTeam(widget.teamName)
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                      softWrap: true,
                    ),
                  ),
                  MatchResultScorePill(
                    matchResult: result,
                    teamName: widget.teamName,
                  ),
                  Expanded(
                    child: Text(
                      result.opponentTeam,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: result.isOpponentTeam(widget.teamName)
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                      textAlign: TextAlign.right,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  String getEnemyTeamName(MatchResult match, String teamName) {
    var isFavoriteTeamHome = match.homeTeamName == teamName;
    return isFavoriteTeamHome ? match.opponentTeam : match.homeTeamName;
  }

  int getEnemyTeamScore(MatchResult match, String teamName) {
    var isFavoriteTeamHome = match.homeTeamName == teamName;
    return isFavoriteTeamHome
        ? match.opponentTeamMatchesWon
        : match.homeTeamMatchesWon;
  }

  int getHomeTeamScore(MatchResult match, String teamName) {
    var isFavoriteTeamHome = match.homeTeamName == teamName;
    return isFavoriteTeamHome
        ? match.homeTeamMatchesWon
        : match.opponentTeamMatchesWon;
  }

  void goToMatchResult(MatchResult result, String teamName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MatchResultPage(matchResult: result, teamName: teamName),
      ),
    );
  }
}
