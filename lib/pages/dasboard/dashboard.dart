import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/pages/dasboard/last-matches/last_matches.dart';
import 'package:nuliga_app/pages/dasboard/league-info/league_info.dart';
import 'package:nuliga_app/pages/dasboard/league-table/short_league_table.dart';
import 'package:nuliga_app/pages/dasboard/next-matches/next_matches.dart';
import 'package:nuliga_app/services/followed_teams_provider.dart';
import 'package:nuliga_app/services/shared/http_client.dart';
import 'package:provider/provider.dart';

class TeamOverviewPage extends StatefulWidget {
  const TeamOverviewPage({super.key});

  @override
  State<TeamOverviewPage> createState() => _TeamOverviewPageState();
}

class _TeamOverviewPageState extends State<TeamOverviewPage> {
  HttpClient httpClient = HttpClient();

  Future<void> refresh() {
    httpClient.clearCache();
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
        children: [
          ...teams.map((team) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Constants.pagePadding),
                  child: Text(
                    team.name,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),

                DashboardSection(
                  title: "UP NEXT",
                  onViewAll: () => goToNextMatches(team),
                  child: NextMatches(matchesUrl: team.matchesUrl, team: team),
                ),
                DashboardSection(
                  title: "LAST",
                  child: LastMatches(team: team),
                  onViewAll: () => goToResults(team),
                ),
                SizedBox(height: 48),
              ],
            );
          }),
        ],
      ),
    );
  }

  void goToNextMatches(FollowedClub team) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamDetailsPage(team: team)),
    );
  }

  void goToResults(FollowedClub team) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailsPage(team: team, startIndex: 2),
      ),
    );
  }
}

class DashboardSection extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onViewAll;

  const DashboardSection({
    super.key,
    required this.title,
    required this.child,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.pagePadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              TextButton(onPressed: onViewAll, child: Text("View all")),
            ],
          ),
        ),
        child,
      ],
    );
  }
}

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(scrollDirection: Axis.horizontal, children: []);
  }
}
