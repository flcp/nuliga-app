import 'package:flutter/material.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_details_page.dart';
import 'package:nuliga_app/pages/team-overview/team_overview_next_matches_list.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:nuliga_app/services/shared/http.dart';
import 'package:provider/provider.dart';

class NextMatchesOverviewPage extends StatefulWidget {
  const NextMatchesOverviewPage({super.key});

  @override
  State<NextMatchesOverviewPage> createState() =>
      _NextMatchesOverviewPageState();
}

class _NextMatchesOverviewPageState extends State<NextMatchesOverviewPage> {
  Future<void> refresh() {
    clearCache();
    setState(() {});
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FollowedTeamsProvider>();
    final teams = provider.followedTeams;

    return Scaffold(
      appBar: AppBar(title: Text("Overview")),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView(
          children: teams.map((team) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        team.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NextMatchesDetailsPage(team: team),
                            ),
                          );
                        },
                        child: Text("View all"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TeamOverviewNextMatchesList(
                    matchesUrl: team.matchesUrl,
                    team: team,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
