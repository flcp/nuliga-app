import 'package:flutter/material.dart';
import 'package:nuliga_app/model/match_result.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/match-result/match_result_page.dart';
import 'package:nuliga_app/pages/shared/nothing_to_display_indicator.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';
import 'package:nuliga_app/services/last_matches_service.dart';
import 'package:nuliga_app/services/shared/date.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http_client.dart';

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
  final httpClient = HttpClient();

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

        return RefreshIndicator(
          onRefresh: refresh,
          child: ListView(
            children: [
              if (matchResults.isEmpty) NothingToDisplayIndicator(),
              ...matchResults.map((result) {
                return ListTile(
                  onTap: () => goToMatchResult(result, widget.teamName),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${result.homeTeamMatchesWon} : ${result.opponentTeamMatchesWon}  ',
                        style: TextStyle(
                          fontSize: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  leading: WinLossIndicator(
                    size: 10,
                    status: result.getMatchStatusForTeam(widget.teamName),
                    isTextDisplayed: true,
                  ),
                  subtitle: Text(Date.getDateString(result.time)),
                  title: Text(
                    result.homeTeamName == widget.teamName
                        ? result.opponentTeamName
                        : result.homeTeamName,

                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }),
            ],
          ),
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

  Future<void> refresh() {
    httpClient.clearCache();
    setState(() {});
    return Future.value();
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
