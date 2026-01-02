import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/dasboard/dashboard_section.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/pages/dasboard/last-matches/last_matches.dart';
import 'package:nuliga_app/pages/dasboard/league-info/league_info.dart';
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
                LeagueInfo(team: team),
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
