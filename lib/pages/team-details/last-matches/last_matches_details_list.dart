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
              trailing: Icon(Icons.chevron_right),
              title: Row(
                children: [
                  Expanded(
                    child: LastMatchesTeamName(
                      teamName: result.homeTeamName,
                      align: TextAlign.left,
                      highlighted: result.isHomeTeam(widget.teamName),
                    ),
                  ),
                  MatchResultScorePill(
                    matchResult: result,
                    teamName: widget.teamName,
                  ),

                  Expanded(
                    child: LastMatchesTeamName(
                      teamName: result.opponentTeamName,
                      align: TextAlign.right,
                      highlighted: result.isOpponentTeam(widget.teamName),
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

class LastMatchesTeamName extends StatelessWidget {
  const LastMatchesTeamName({
    super.key,
    required this.teamName,
    required this.align,
    required this.highlighted,
  });

  final String teamName;
  final TextAlign align;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Text(
      teamName,
      style: TextStyle(
        fontWeight: highlighted ? FontWeight.w500 : FontWeight.normal,
      ),
      textAlign: align,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
    );
  }
}
