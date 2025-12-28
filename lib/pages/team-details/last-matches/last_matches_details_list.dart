import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/match-result/match_result_page.dart';
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
              onTap: () => goToMatchResult(result),
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              trailing: Icon(Icons.chevron_right),
              horizontalTitleGap: 0,
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      result.homeTeamName,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.left,
                      softWrap: true,
                    ),
                  ),
                  ScorePill(matchResult: result, teamName: widget.teamName),
                  Expanded(
                    child: Text(
                      result.opponentTeam,
                      style: Theme.of(context).textTheme.bodyLarge,
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

  void goToMatchResult(MatchResult result) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchResultPage(matchResult: result),
      ),
    );
  }
}

class ScorePill extends StatelessWidget {
  final MatchResult matchResult;
  final String teamName;

  const ScorePill({
    super.key,
    required this.matchResult,
    required this.teamName,
  });

  @override
  Widget build(BuildContext context) {
    final leftScore = matchResult.homeTeamMatchesWon;
    final rightScore = matchResult.opponentTeamMatchesWon;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          WinLossIndicator(
            size: 10,
            status: matchResult.getMatchStatusForTeam(teamName),
          ),
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
