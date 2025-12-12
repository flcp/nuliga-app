import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_list_item.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_list_page.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http.dart';
import 'package:provider/provider.dart';

class NextMatchesOverviewList extends StatefulWidget {
  const NextMatchesOverviewList({super.key});

  @override
  State<NextMatchesOverviewList> createState() =>
      _NextMatchesOverviewListState();
}

class _NextMatchesOverviewListState extends State<NextMatchesOverviewList> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FollowedTeamsProvider>();

    final teams = provider.followedTeams;

    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView(
        children: teams.map((team) {
          return FutureBuilder(
            future: NextMatchesService.getNextTwoMatches(
              team.matchesUrl,
              team.name,
            ),
            builder: (context, snapshot) {
              final nextTwoMatches = getDataOrEmptyList(snapshot);

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NextMatchesListPage(team: team),
                    ),
                  );
                },

                child: Card(
                  margin: EdgeInsets.fromLTRB(16, 4, 16, 24),
                  child: Column(
                    children: [
                      if (snapshot.connectionState == ConnectionState.waiting)
                        SizedBox(height: 144, child: LoadingIndicator())
                      else
                        ...nextTwoMatches.map(
                          (match) => NextMatchesListItem(
                            match: match,
                            hometeam: team.name,
                            matchOverviewUrl: team.matchesUrl,
                            highlighted: true,
                            displayOnlyOpponentName: false,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Future<void> refresh() {
    clearCache();
    setState(() {});
    return Future.value();
  }
}
