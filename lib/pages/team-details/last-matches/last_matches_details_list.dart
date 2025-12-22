import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/match-result/match_result_page.dart';
import 'package:nuliga_app/services/last_matches_service.dart';
import 'package:nuliga_app/services/shared/date.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LastMatchesDetailsList extends StatefulWidget {
  final String matchOverviewUrl;
  final FollowedClub team;

  const LastMatchesDetailsList({
    super.key,
    required this.matchOverviewUrl,
    required this.team,
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
        widget.team.name,
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
                  onTap: () => goToMatchResult(result, widget.team),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  trailing: Icon(Icons.chevron_right),
                  subtitle: Row(
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
                          result.homeTeamName,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                fontWeight:
                                    result.homeTeamMatchesWon >
                                        result.opponentTeamMatchesWon
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                          textAlign: TextAlign.left,
                          softWrap: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Text(
                          "${result.homeTeamMatchesWon} - ${result.opponentTeamMatchesWon}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          result.opponentTeam,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                fontWeight:
                                    result.opponentTeamMatchesWon >
                                        result.homeTeamMatchesWon
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                          textAlign: TextAlign.right,
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

  void goToMatchResult(MatchResult result, FollowedClub homeTeam) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MatchResultPage(matchResult: result, homeTeam: homeTeam),
      ),
    );
  }
}
