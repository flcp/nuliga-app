import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_list_item.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http.dart';
import 'package:provider/provider.dart';

class NextMatchesSummaryList extends StatefulWidget {
  final List<FollowedClub> teams;

  const NextMatchesSummaryList({super.key, required this.teams});

  @override
  State<NextMatchesSummaryList> createState() => _NextMatchesSummaryListState();
}

class _NextMatchesSummaryListState extends State<NextMatchesSummaryList> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView(
        children: widget.teams.map((team) {
          return FutureBuilder(
            future: NextMatchesService.getNextTwoMatches(
              team.matchesUrl,
              team.name,
            ),
            builder: (context, snapshot) {
              final nextTwoMatches = getDataOrEmptyList(snapshot);

              return InkWell(
                onTap: () =>
                    context.read<FollowedTeamsProvider>().selectTeam(team),
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
