import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/match-result/match_result_page.dart';
import 'package:nuliga_app/services/last_matches_service.dart';
import 'package:nuliga_app/services/shared/date.dart';
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
          children: matchResults
              .map(
                (result) => ListTile(
                  onTap: () => goToMatchResult(result),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16.0,
                        color: Theme.of(context).disabledColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(getDateString(result.time)),
                      ),
                    ],
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          result.homeTeam,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.right,
                          softWrap: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                        child: Text(
                          result.homeTeamMatchesWon.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
                        child: Text(
                          result.opponentTeamMatchesWon.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          result.opponentTeam,
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  String getEnemyTeamName(MatchResult match, String teamName) {
    var isFavoriteTeamHome = match.homeTeam == teamName;
    return isFavoriteTeamHome ? match.opponentTeam : match.homeTeam;
  }

  int getEnemyTeamScore(MatchResult match, String teamName) {
    var isFavoriteTeamHome = match.homeTeam == teamName;
    return isFavoriteTeamHome
        ? match.opponentTeamMatchesWon
        : match.homeTeamMatchesWon;
  }

  int getHomeTeamScore(MatchResult match, String teamName) {
    var isFavoriteTeamHome = match.homeTeam == teamName;
    return isFavoriteTeamHome
        ? match.homeTeamMatchesWon
        : match.opponentTeamMatchesWon;
  }

  void goToMatchResult(MatchResult result) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchResultPage(matchResult: result),
      ),
    );
  }
}
