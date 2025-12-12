import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_standing.dart';
import 'package:nuliga_app/pages/league-table/league_table_details_ranking_list_item.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/shared/nothing_to_display_indicator.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http.dart';
import '../../services/league_table_service.dart';

class LeagueTableDetailsRankingList extends StatefulWidget {
  final String url;
  final String teamName;

  const LeagueTableDetailsRankingList({
    required this.url,
    required this.teamName,
    super.key,
  });

  @override
  State<LeagueTableDetailsRankingList> createState() =>
      _LeagueTableDetailsRankingListState();
}

class _LeagueTableDetailsRankingListState
    extends State<LeagueTableDetailsRankingList> {
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
                children: [
                  ...teamStandings.map(
                    (teamStanding) => LeagueTableDetailsRankingListItem(
                      teamStanding: teamStanding,
                      team: widget.teamName,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
