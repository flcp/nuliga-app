import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/league-table/league_table_page.dart';
import 'package:nuliga_app/pages/league-table/league_table_ranking_list.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:nuliga_app/services/league_table_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http.dart';
import 'package:provider/provider.dart';

class LeagueTableOverviewList extends StatefulWidget {
  const LeagueTableOverviewList({super.key});

  @override
  State<LeagueTableOverviewList> createState() =>
      _LeagueTableOverviewListState();
}

class _LeagueTableOverviewListState extends State<LeagueTableOverviewList> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FollowedTeamsProvider>();

    final teams = provider.followedTeams;

    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView(
        children: [
          ...teams.map((team) {
            return FutureBuilder(
              future: LeagueTableService.getThreeClosestRankingsToTeam(
                team.rankingTableUrl,
                team,
              ),
              builder: (context, snapshot) {
                final threeClosestRankings = getDataOrEmptyList(snapshot);

                return InkWell(
                  onTap: () {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeagueTablePage(team: team),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: threeClosestRankings
                          .map((r) => Text(r.teamName))
                          .toList(),
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Future<void> refresh() async {
    clearCache();
    setState(() {});
    return Future.value();
  }
}
