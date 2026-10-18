import 'package:flutter/material.dart';

import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/services/league-table/model/league_team_ranking.dart';
import 'package:nuliga_app/pages/team-details/league-table/league_table_details_ranking_list_item.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/shared/nothing_to_display_indicator.dart';
import 'package:nuliga_app/services/league-table/repository/league_table_repository.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http_client.dart';

class LeagueTableDetailsRankingList extends StatefulWidget {
  final String url;
  final String teamName;
  final String matchOverviewUrl;

  const LeagueTableDetailsRankingList({
    required this.url,
    required this.teamName,
    super.key,
    required this.matchOverviewUrl,
  });

  @override
  State<LeagueTableDetailsRankingList> createState() =>
      _LeagueTableDetailsRankingListState();
}

class _LeagueTableDetailsRankingListState
    extends State<LeagueTableDetailsRankingList> {
  final httpClient = HttpClient();
  final leagueTableRepository = LeagueTableRepository();
  late Future<List<LeagueTeamRanking>> _leagueTeamRankingsFuture;

  @override
  void initState() {
    super.initState();
    _leagueTeamRankingsFuture = leagueTableRepository.getLeagueTeamRankings(
      widget.url,
    );
  }

  Future<void> refresh() {
    httpClient.clearCache();
    setState(() {
      _leagueTeamRankingsFuture = leagueTableRepository.getLeagueTeamRankings(
        widget.url,
      );
    });
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LeagueTeamRanking>>(
      future: _leagueTeamRankingsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        }

        final teamStandings = getDataOrEmptyList(snapshot);

        return RefreshIndicator(
          onRefresh: refresh,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.pagePadding,
            ),
            child: ListView(
              children: [
                if (teamStandings.isEmpty) NothingToDisplayIndicator(),
                if (teamStandings.isNotEmpty) ...[
                  SizedBox(height: Constants.smallCardPadding),
                  ...teamStandings.map(
                    (teamStanding) => LeagueTableDetailsRankingListItem(
                      teamStanding: teamStanding,
                      team: widget.teamName,
                      matchOverviewUrl: widget.matchOverviewUrl,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
