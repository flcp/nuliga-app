import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/shared/constants.dart';
import 'package:nuliga_app/pages/team-details/team_details_page.dart';
import 'package:nuliga_app/pages/team-overview/last-matches/last_matches.dart';
import 'package:nuliga_app/pages/team-overview/league-ranking-cards/league_ranking_cards.dart';
import 'package:nuliga_app/pages/team-overview/league-table/short_league_table.dart';
import 'package:nuliga_app/pages/team-overview/next-matches/next_matches.dart';
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

    return Padding(
      padding: const EdgeInsets.all(Constants.pagePadding),
      child: RefreshIndicator(
        onRefresh: refresh,
        child: ListView(
          children:
          [LeagueRankingCards(teams: teams),
          ...teams.map((team) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team.name,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "UPCOMING",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () => goToNextMatches(team),
                      child: Text("View all"),
                    ),
                  ],
                ),
                NextMatches(matchesUrl: team.matchesUrl, team: team),
                SizedBox(height: 24),

                Text(
                  "RANKING",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 12),
                ShortLeagueTable(team: team),
                SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "LAST",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () => goToResults(team),
                      child: Text("View all"),
                    ),
                  ],
                ),
                LastMatches(team: team),

                SizedBox(height: 48),
              ],
            );
          })],
        ),
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
