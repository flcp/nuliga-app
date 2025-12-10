import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_list_item.dart';
import 'package:nuliga_app/pages/shared/loading_indicator.dart';
import 'package:nuliga_app/services/next_matches_service.dart';
import 'package:nuliga_app/services/shared/future_async_snapshot.dart';
import 'package:nuliga_app/services/shared/http.dart';

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

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Text(
                      team.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (snapshot.connectionState == ConnectionState.waiting)
                      SizedBox(height: 64, child: LoadingIndicator())
                    else
                      ...nextTwoMatches.map(
                        (match) => NextMatchesListItem(
                          match: match,
                          hometeam: team.name,
                          matchOverviewUrl: team.matchesUrl,
                          highlighted: false,
                        ),
                      ),
                  ],
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
