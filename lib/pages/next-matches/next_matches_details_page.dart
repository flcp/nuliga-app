import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/team-details/last_matches_details_list.dart';
import 'package:nuliga_app/pages/team-details/league_table_details_ranking_list.dart';
import 'package:nuliga_app/pages/next-matches/next_matches_details_list.dart';
import 'package:nuliga_app/pages/shared/action_bar_open_link_button.dart';

class NextMatchesDetailsPage extends StatelessWidget {
  final FollowedClub team;
  final int startIndex;

  const NextMatchesDetailsPage({
    required this.team,
    super.key,
    this.startIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: startIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text(team.name),
          actions: [
            ActionBarOpenLinkButton(
              selectedFollowedTeam: team,
              urlAccessor: (i) => i.rankingTableUrl,
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.event)),
              Tab(icon: Icon(Icons.format_list_numbered)),
              Tab(icon: Icon(Icons.history)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Expanded(
                  child: NextMatchesDetailsList(
                    teamName: team.name,
                    matchOverviewUrl: team.matchesUrl,
                  ),
                ),
              ],
            ),
            LeagueTableDetailsRankingList(
              teamName: team.name,
              url: team.rankingTableUrl,
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
