import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/pages/team-overview/league-table/team_overview_league_table_excerpt.dart';
import 'package:nuliga_app/pages/team-overview/next-matches/team_overview_next_matches_list.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:nuliga_app/services/shared/http.dart';
import 'package:provider/provider.dart';

class TeamOverviewPage extends StatefulWidget {
  const TeamOverviewPage({super.key});

  @override
  State<TeamOverviewPage> createState() => _TeamOverviewPageState();
}

class _TeamOverviewPageState extends State<TeamOverviewPage> {
  Future<void> refresh() {
    clearCache();
    setState(() {});
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FollowedTeamsProvider>();
    final teams = provider.followedTeams;

    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView(
        children: teams.map((team) {
          return Column(
            children: [
              Text(
                team.name,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upcoming",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () => goToNextMatches(team),
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TeamOverviewLeagueTableExcerpt(team: team),
              ),
              SizedBox(height: 48),
            ],
          );
        }).toList(),
      ),
    );
  }

  void goToNextMatches(FollowedClub team) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamDetailsPage(team: team)),
    );
  }
}
