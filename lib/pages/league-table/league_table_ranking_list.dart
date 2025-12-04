import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_standing.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/shared/nothing_to_display_indicator.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http.dart';
import '../../services/league_table_service.dart';

class LeagueTableRankingList extends StatefulWidget {
  final String url;
  final String teamName;

  const LeagueTableRankingList({
    required this.url,
    required this.teamName,
    super.key,
  });

  @override
  State<LeagueTableRankingList> createState() => _LeagueTableRankingListState();
}

class _LeagueTableRankingListState extends State<LeagueTableRankingList> {
  Future<void> refresh() {
    clearCache();
    setState(() {});
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LeagueTeamRanking>>(
      future: LeagueTableService.getLeagueTeamRankings(widget.url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        }

        final teamStandings = getDataOrEmptyList(snapshot);

        return RefreshIndicator(
          onRefresh: refresh,
          child: Stack(
            children: [
              if (teamStandings.isEmpty) NothingToDisplayIndicator(),
              ListView(
                children: teamStandings
                    .map(
                      (teamStanding) => ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 8,
                              children: [
                                Text("${teamStanding.rank.toString()}."),
                                Text(teamStanding.teamName),
                              ],
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 24,
                              children: [
                                Text(teamStanding.leaguePointsWon.toString()),
                                Text(
                                  "${teamStanding.wins}:${teamStanding.draws}:${teamStanding.losses}",
                                ),
                              ],
                            ),
                          ],
                        ),
                        selected: teamStanding.teamName == widget.teamName,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
