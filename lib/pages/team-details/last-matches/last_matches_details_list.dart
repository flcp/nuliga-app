import 'package:flutter/material.dart';
import 'package:nuliga_app/localization/app_localizations.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/matches/last-matches/model/match_result.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/match-result/match_result_page.dart';
import 'package:nuliga_app/pages/shared/nothing_to_display_indicator.dart';
import 'package:nuliga_app/pages/shared/score_pill.dart';
import 'package:nuliga_app/services/matches/last-matches/last_matches_service.dart';
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
  late Future<List<MatchResult>> _lastMatchesFuture;

  @override
  void initState() {
    super.initState();
    _lastMatchesFuture = LastMatchesService.getLastMatchesForTeam(
      widget.matchOverviewUrl,
      widget.teamName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return FutureBuilder(
      future: _lastMatchesFuture,
      builder: (context, snapshot) {
        final date = context.getDate();
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        }

        final matchResults = getDataOrEmptyList(snapshot).reversed;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.bigCardPadding,
          ),
          child: RefreshIndicator(
            onRefresh: refresh,
            child: ListView(
              children: [
                if (matchResults.isEmpty) NothingToDisplayIndicator(),
                ...matchResults.map((result) {
                  return InkWell(
                    onTap: () => goToMatchResult(result, widget.teamName),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Constants.smallCardPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 8,
                            children: [
                              WinLossIndicator(
                                isTextDisplayed: true,
                                size: 10,
                                status: result.getMatchStatusForTeam(
                                  widget.teamName,
                                ),
                              ),

                              Text(
                                result
                                    .getMatchStatusForTeam(widget.teamName)
                                    .localized(localization),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text("·"),
                              Text(
                                context.getDate().getShortDateString(
                                  result.time,
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text("·"),
                              Text(
                                "${result.time.hour}:${result.time.minute.toString().padLeft(2, "0")}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text("·"),
                              Text(
                                result.isHomeTeam(widget.teamName)
                                    ? localization.homeGame_short
                                    : localization.awayGame_short,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                result.getEnemyTeamName(widget.teamName),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "${result.homeTeamMatchesWon.toString()} : ${result.opponentTeamMatchesWon.toString()}",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );

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
                    subtitle: Text(date.getDateString(result.time)),
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
    setState(() {
      _lastMatchesFuture = LastMatchesService.getLastMatchesForTeam(
        widget.matchOverviewUrl,
        widget.teamName,
      );
    });
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
