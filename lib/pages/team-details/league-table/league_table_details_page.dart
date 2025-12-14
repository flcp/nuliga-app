import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/pages/team-details/league-table/league_table_details_ranking_list.dart';
import 'package:nuliga_app/pages/shared/action_bar_open_link_button.dart';

class LeagueTableDetailsPage extends StatelessWidget {
  final FollowedClub team;

  const LeagueTableDetailsPage({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tabelle"),
        actions: [
          ActionBarOpenLinkButton(
            selectedFollowedTeam: team,
            urlAccessor: (i) => i.rankingTableUrl,
          ),
        ],
      ),
      body: LeagueTableDetailsRankingList(
        teamName: team.name,
        url: team.rankingTableUrl,
      ),
    );
  }
}
