import 'package:flutter/material.dart';
import 'package:nuliga_app/model/league_team_standing.dart';
import 'package:nuliga_app/pages/team-details/league-table/league_table_details_ranking_list_item.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/pages/shared/nothing_to_display_indicator.dart';
import 'package:nuliga_app/services/league-table/league_table_repository.dart';
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

  Future<void> refresh() {
    httpClient.clearCache();
    setState(() {});
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LeagueTeamRanking>>(
      future: leagueTableRepository.getLeagueTeamRankings(widget.url),
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
                  LeagueTableDetailsRankingListHeader(),
                  ...teamStandings.map(
                    (teamStanding) => LeagueTableDetailsRankingListItem(
                      teamStanding: teamStanding,
                      team: widget.teamName,
                      matchOverviewUrl: widget.matchOverviewUrl,
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

class LeagueTableDetailsRankingListHeader extends StatelessWidget {
  const LeagueTableDetailsRankingListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),

      title: DefaultTextStyle(
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 24, child: Text("#", textAlign: TextAlign.center)),
            SizedBox(width: 8),
            Expanded(
              child: Text("Name", overflow: TextOverflow.ellipsis, maxLines: 1),
            ),
            SizedBox(width: 20, child: Text("W")),
            SizedBox(width: 16, child: Text("D")),
            SizedBox(width: 16, child: Text("L")),
            SizedBox(width: 24, child: Text("Pts")),
            SizedBox(width: 18, child: Text("M", textAlign: TextAlign.center)),
            SizedBox(width: 40),
          ],
        ),
      ),
    );
  }
}
