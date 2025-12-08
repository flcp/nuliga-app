import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/services/last_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';

class LastMatchesList extends StatefulWidget {
  final String matchOverviewUrl;
  final String teamName;

  const LastMatchesList({
    super.key,
    required this.matchOverviewUrl,
    required this.teamName,
  });

  @override
  State<LastMatchesList> createState() => _LastMatchesListState();
}

class _LastMatchesListState extends State<LastMatchesList> {
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

        final matchResults = getDataOrEmptyList(snapshot);

        return ListView(
          children: matchResults
              .map(
                (match) => ListTile(
                  leading: createWinLossIndicator(match, widget.teamName),
                  title: Row(
                    children: [
                      Column(
                        children: [
                          Text(getEnemyTeamName(match, widget.teamName)),
                        ],
                      ),
                    ],
                  ),
                  trailing: Text(
                    "${getHomeTeamScore(match, widget.teamName)} - ${getEnemyTeamScore(match, widget.teamName)}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  static Widget wonIndicator = Icon(
    Icons.change_history,
    color: Colors.green.shade700,
    size: 18,
  );

  static Widget lostIndicator = Transform.flip(
    flipY: true,
    child: Icon(
      Icons.change_history_outlined,
      color: Colors.red.shade700,
      size: 18,
    ),
  );

  static Widget drawIndicator = Icon(
    Icons.remove,
    size: 18,
    color: Colors.grey,
  );

  Widget createWinLossIndicator(MatchResult match, String favoriteTeam) {
    if (match.homeTeamMatchesWon == match.opponentTeamMatchesWon) {
      return drawIndicator;
    }

    var isFavoriteTeamHome = match.homeTeam == favoriteTeam;
    var favoriteTeamWins = isFavoriteTeamHome
        ? match.homeTeamMatchesWon
        : match.opponentTeamMatchesWon;
    var enemyTeamWins = isFavoriteTeamHome
        ? match.opponentTeamMatchesWon
        : match.homeTeamMatchesWon;
    var hasFavoriteTeamWon = favoriteTeamWins > enemyTeamWins;

    return hasFavoriteTeamWon ? wonIndicator : lostIndicator;
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
}
