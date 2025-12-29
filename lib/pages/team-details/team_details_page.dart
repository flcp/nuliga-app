import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/team-details/last-matches/last_matches_details_list.dart';
import 'package:nuliga_app/pages/team-details/league-table/league_table_details_ranking_list.dart';
import 'package:nuliga_app/pages/team-details/next-matches/next_matches_details_list.dart';
import 'package:nuliga_app/pages/shared/action_bar_open_link_button.dart';

class TeamDetailsPage extends StatelessWidget {
  final FollowedClub team;
  final int startIndex;

  const TeamDetailsPage({required this.team, super.key, this.startIndex = 0});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: startIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text(team.name),
          actions: [
            ActionBarFollowedTeamOpenLinkButton(
              selectedFollowedTeam: team,
              urlAccessor: (i) => i.rankingTableUrl,
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.event), text: "Upcoming"),
              Tab(icon: Icon(Icons.format_list_numbered), text: "Tabelle"),
              Tab(icon: Icon(Icons.history), text: "Results"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NextMatchesDetailsList(
              teamName: team.name,
              matchOverviewUrl: team.matchesUrl,
            ),
            LeagueTableDetailsRankingList(
              teamName: team.name,
              url: team.rankingTableUrl,
              matchOverviewUrl: team.matchesUrl,
            ),
            LastMatchesDetailsList(
              teamName: team.name,
              matchOverviewUrl: team.matchesUrl,
            ),
          ],
        ),
      ),
    );
  }
}
